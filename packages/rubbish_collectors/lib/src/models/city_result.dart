import 'package:rubbish_collectors/src/models/models.dart';

class CityModel extends CityProvinceBase {
  final String id;

  final String name;
  final String provinceId;

  const CityModel({
    required this.id,
    required this.name,
    required this.provinceId,
  }) : super(id: id, name: name);

  factory CityModel.fromJson(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'],
      name: map['name'],
      provinceId: map['provinceId'],
    );
  }
}
