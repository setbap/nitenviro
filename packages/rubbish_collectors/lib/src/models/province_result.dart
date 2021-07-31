import 'package:rubbish_collectors/src/models/models.dart';

class ProvinceModel extends CityProvinceBase {
  final String id;

  final String name;

  const ProvinceModel({
    required this.id,
    required this.name,
  }) : super(id: id, name: name);

  factory ProvinceModel.fromJson(Map<String, dynamic> map) {
    return ProvinceModel(
      id: map['id'],
      name: map['name'],
    );
  }
}
