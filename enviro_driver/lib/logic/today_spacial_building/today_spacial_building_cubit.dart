import 'dart:developer';

import 'package:location/location.dart';
import 'package:bloc/bloc.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:meta/meta.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

part 'today_spacial_building_state.dart';

class TodaySpacialRequestCubit extends Cubit<TodaySpacialRequestState> {
  final RubbishCollectorsApi _rubbishCollectorsApi;
  final Location location;

  TodaySpacialRequestCubit({required RubbishCollectorsApi rubbishCollectorsApi})
      : _rubbishCollectorsApi = rubbishCollectorsApi,
        location = Location(),
        super(const TodaySpacialRequestInitial());

  Future<void> getTodaySpacialRequest() async {
    emit(TodaySpacialRequestLoading(spacialRequest: state.spacialRequest));
    final locationData = await getCurrentLocation();

    try {
      final spacialRequest =
          await _rubbishCollectorsApi.getTodaySpacialBuilding(
        sourceLatitude: locationData?.latitude,
        sourceLongitude: locationData?.longitude,
      );
      if (spacialRequest.isSuccess) {
        emit(
          TodaySpacialRequestSuccess(
            spacialRequest: spacialRequest.value ?? [],
          ),
        );
      } else {
        // agar error dar dataye bargashti bashad
        emit(
          TodaySpacialRequestError(
            spacialRequest: state.spacialRequest,
            message: spacialRequest.errors[0].message ?? "",
          ),
        );
      }
    } catch (e) {
      // agar error dar hengam ijad darkhast etefaq bioftad
      emit(
        TodaySpacialRequestError(
          spacialRequest: state.spacialRequest,
          message: "مشکل در برقراری ارتباط با سرور",
        ),
      );
    }
  }

  Future<bool?> setRequestToOngoing({
    required String id,
    String? driverMessage,
  }) async {
    emit(TodaySpacialRequestLoading(spacialRequest: state.spacialRequest));

    try {
      final spacialRequest = await _rubbishCollectorsApi.acceptTodayBuilding(
        id: id,
        isSpacial: true,
        driverMessage: driverMessage,
      );

      if (spacialRequest.isSuccess) {
        emit(
          TodaySpacialRequestSuccess(
            spacialRequest:
                state.spacialRequest.where((el) => el.id != id).toList(),
          ),
        );
        return true;
      } else {
        // agar error dar dataye bargashti bashad
        emit(
          TodaySpacialRequestError(
            spacialRequest: state.spacialRequest,
            message: spacialRequest.errors[0].message ?? "",
          ),
        );
      }
    } catch (e) {
      // agar error dar hengam ijad darkhast etefaq bioftad
      emit(
        TodaySpacialRequestError(
          spacialRequest: state.spacialRequest,
          message: "ثبت انجام نشد مشکل در برقراری ارتباط با سرور",
        ),
      );
    }
  }

  Future<LocationData?> getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          emit(
            TodaySpacialRequestLoading(
              spacialRequest: state.spacialRequest,
              message:
                  "سرویس موقعیت مکانی شما فعال نیست. لطفا از بخش تنظیمات فعال کنید",
            ),
          );
          return null;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        log("ejaze dade nashode");
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          emit(
            TodaySpacialRequestLoading(
              spacialRequest: state.spacialRequest,
              message:
                  "اجازه دسترسی به موقعیت مکانی داده نشده است. لطفا از بخش تنظیمات به برنامه اجازه دسترسی به موقعیت مکانی دهید",
            ),
          );
          return null;
        }
      }
      log("ejze dard dar hal gereftan makan");
      _locationData = await location.getLocation();
      emit(
        TodaySpacialRequestLoading(
          spacialRequest: state.spacialRequest,
          message: "موقعیت مکانی با موفقیت دریافت شد.",
        ),
      );
      log("lat:${_locationData.latitude},lng:${_locationData.longitude}");
      return _locationData;
    } catch (e) {
      emit(
        TodaySpacialRequestLoading(
          spacialRequest: state.spacialRequest,
          message: "خطا در دریافت اطلاعات موقعیت مکانی.",
        ),
      );
    }
  }
}
