import 'package:collection/collection.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

class CityProvinceState {
  final List<ProvinceModel> provinces;
  final Map<String, List<CityModel>> cities;

  CityProvinceState({
    required this.provinces,
    required this.cities,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final collectionEquals = const DeepCollectionEquality().equals;

    return other is CityProvinceState &&
        collectionEquals(other.provinces, provinces) &&
        collectionEquals(other.cities, cities);
  }

  @override
  int get hashCode => provinces.hashCode ^ cities.hashCode;

  CityProvinceState copyWith({
    List<ProvinceModel>? provinces,
    Map<String, List<CityModel>>? cities,
  }) {
    return CityProvinceState(
      provinces: provinces ?? this.provinces,
      cities: cities ?? this.cities,
    );
  }
}
