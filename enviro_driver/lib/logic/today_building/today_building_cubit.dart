import 'dart:developer';

import 'package:location/location.dart';
import 'package:bloc/bloc.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:meta/meta.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';
part 'today_building_state.dart';

class TodayBuildingCubit extends Cubit<TodayBuildingState> {
  final RubbishCollectorsApi _rubbishCollectorsApi;
  final Location location;

  TodayBuildingCubit({required RubbishCollectorsApi rubbishCollectorsApi})
      : _rubbishCollectorsApi = rubbishCollectorsApi,
        location = Location(),
        super(const TodayBuildingInitial());

  Future<void> getTodayBuilding() async {
    emit(TodayBuildingLoading(buildings: state.buildings));
    final locationData = await getCurrentLocation();

    try {
      final buildings = await _rubbishCollectorsApi.getTodayBuilding(
        sourceLatitude: locationData?.latitude,
        sourceLongitude: locationData?.longitude,
      );
      if (buildings.isSuccess) {
        emit(
          TodayBuildingSuccess(
            buildings: buildings.value ?? [],
          ),
        );
      } else {
        // agar error dar dataye bargashti bashad
        emit(
          TodayBuildingError(
            buildings: state.buildings,
            message: buildings.errors[0].message ?? "",
          ),
        );
      }
    } catch (e) {
      // agar error dar hengam ijad darkhast etefaq bioftad
      emit(
        TodayBuildingError(
          buildings: state.buildings,
          message: "مشکل در برقراری ارتباط با سرور",
        ),
      );
    }
  }

  Future<bool?> setRequestToOngoing({
    required String id,
    String? driverMessage,
  }) async {
    emit(TodayBuildingLoading(buildings: state.buildings));

    try {
      final spacialRequest = await _rubbishCollectorsApi.acceptTodayBuilding(
        id: id,
        isSpacial: false,
        driverMessage: driverMessage,
      );

      if (spacialRequest.isSuccess) {
        emit(
          TodayBuildingSuccess(
            buildings: state.buildings.where((el) => el.id != id).toList(),
          ),
        );
        return true;
      } else {
        // agar error dar dataye bargashti bashad
        emit(
          TodayBuildingError(
            buildings: state.buildings,
            message: spacialRequest.errors[0].message ?? "",
          ),
        );
      }
    } catch (e) {
      // agar error dar hengam ijad darkhast etefaq bioftad
      emit(
        TodayBuildingError(
          buildings: state.buildings,
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
            TodayBuildingLoading(
              buildings: state.buildings,
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
            TodayBuildingLoading(
              buildings: state.buildings,
              message:
                  "اجازه دسترسی به موقعیت مکانی داده نشده است. لطفا از بخش تنظیمات به برنامه اجازه دسترسی به موقعیت مکانی دهید",
            ),
          );
          return null;
        }
      }
      log("ejze dard dar hal gereftan makan");
      _locationData = await location.getLocation();
      // emit(
      //   TodayBuildingLoading(
      //     buildings: state.buildings,
      //     message: "موقعیت مکانی با موفقیت دریافت شد.",
      //   ),
      // );
      log("lat:${_locationData.latitude},lng:${_locationData.longitude}");
      return _locationData;
    } catch (e) {
      emit(
        TodayBuildingLoading(
          buildings: state.buildings,
          message: "خطا در دریافت اطلاعات موقعیت مکانی.",
        ),
      );
    }
  }
}
