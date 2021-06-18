import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitenviro/logic/generic_api_state.dart';
import 'package:nitenviro/models/location_model.dart';
import 'package:location/location.dart';

class LocationRequestCubit extends Cubit<GenericApiState<LocationModel>> {
  final Location _location;
  LocationRequestCubit({required Location location})
      : _location = location,
        super(
          const GenericApiState<LocationModel>(
            isLoading: false,
            error: "",
          ),
        );

  getCurrentLocation() async {
    PermissionStatus? _permissionGranted;

    emit(state.copyWith(
      isLoading: true,
      error: "",
    ));

    var _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        emit(state.copyWith(
          isLoading: false,
          error: "دزخواست برای تعیین موقعیت مکانی با شکست مواجه شد.",
        ));
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        emit(
          state.copyWith(
            isLoading: false,
            error: "اجازه دسترسی به موقعیت مکانی داده نشد.",
          ),
        );
        return;
      }
    }
    try {
      final _locationData = await _location.getLocation();
      emit(
        state.copyWith(
          isLoading: false,
          error: "",
          data: LocationModel(
            latitude: _locationData.latitude,
            longitude: _locationData.longitude,
            accuracy: _locationData.accuracy,
            altitude: _locationData.altitude,
            speed: _locationData.speed,
            speedAccuracy: _locationData.speedAccuracy,
            heading: _locationData.heading,
            time: _locationData.time,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: "",
        ),
      );
    }
  }
}
