import 'dart:developer';

import 'package:location/location.dart';

import 'package:bloc/bloc.dart';
import 'package:enviro_driver/models/request_model.dart';

class GetRequestWithLocation extends Cubit<DriverLocationData> {
  final Location location;
  GetRequestWithLocation()
      : location = Location(),
        super(
          const DriverLocationData(
            errror: "",
            lat: 0,
            lng: 0,
            loading: true,
          ),
        );

  Future<void> getCurrentLocation() async {
    emit(state.copyWith(loading: true));
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          log("service faal nist");
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        log("ejaze dade nashode");
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      if (_permissionGranted == PermissionStatus.deniedForever) {
        log("ejaze baraye hamishe rad shode");
      }
      log("ejze dard dar hal gereftan makan");
      _locationData = await location.getLocation();
      log("makan gerefte shod");
      log("lat:${_locationData.latitude},lng:${_locationData.longitude}");
      log("before delay");
      await Future.delayed(const Duration(seconds: 2));
      log("after delay");
      // TODO:set app loading and get date from package
      emit(state.copyWith(
        loading: false,
        lat: _locationData.latitude,
        lng: _locationData.longitude,
      ));
    } catch (e) {
      log(e.toString());
    }
  }
}
