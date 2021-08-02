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
}
