import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.freezed.dart';

@freezed
class LocationModel with _$LocationModel {
  factory LocationModel({
     double? latitude,
     double? longitude,
     double? accuracy,
     double? altitude,
     double? speed,
     double? speedAccuracy,
     double? heading,
     double? time,
  }) = _LocationModel;
}
