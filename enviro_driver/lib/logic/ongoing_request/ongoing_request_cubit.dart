import 'dart:developer';

import 'package:location/location.dart';
import 'package:bloc/bloc.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:meta/meta.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

part 'ongoing_request_state.dart';

class AcceptedRequestCubit extends Cubit<AcceptedRequestState> {
  final RubbishCollectorsApi _rubbishCollectorsApi;
  final Location location;

  AcceptedRequestCubit({required RubbishCollectorsApi rubbishCollectorsApi})
      : _rubbishCollectorsApi = rubbishCollectorsApi,
        location = Location(),
        super(const AcceptedRequestInitial());

  Future<void> getAcceptedRequest() async {
    emit(AcceptedRequestLoading(acceptedRequest: state.acceptedRequest));
    final locationData = await getCurrentLocation();

    try {
      final acceptedRequest =
          await _rubbishCollectorsApi.getTodayOngoingRequests(
        sourceLatitude: locationData?.latitude,
        sourceLongitude: locationData?.longitude,
      );
      if (acceptedRequest.isSuccess) {
        emit(
          AcceptedRequestSuccess(
            acceptedRequest: acceptedRequest.value ?? [],
          ),
        );
      } else {
        // agar error dar dataye bargashti bashad
        emit(
          AcceptedRequestError(
            acceptedRequest: state.acceptedRequest,
            message: acceptedRequest.errors[0].message ?? "",
          ),
        );
      }
    } catch (e) {
      // agar error dar hengam ijad darkhast etefaq bioftad
      emit(
        AcceptedRequestError(
          acceptedRequest: state.acceptedRequest,
          message: "مشکل در برقراری ارتباط با سرور",
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
            AcceptedRequestLoading(
              acceptedRequest: state.acceptedRequest,
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
            AcceptedRequestLoading(
              acceptedRequest: state.acceptedRequest,
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
        AcceptedRequestLoading(
          acceptedRequest: state.acceptedRequest,
          message: "موقعیت مکانی با موفقیت دریافت شد.",
        ),
      );
      log("lat:${_locationData.latitude},lng:${_locationData.longitude}");
      return _locationData;
    } catch (e) {
      emit(
        AcceptedRequestLoading(
          acceptedRequest: state.acceptedRequest,
          message: "خطا در دریافت اطلاعات موقعیت مکانی.",
        ),
      );
    }
  }
}
