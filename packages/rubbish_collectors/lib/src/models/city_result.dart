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

abstract class CityProvinceBase {
  final String name;
  final String id;

  const CityProvinceBase({
    required this.name,
    required this.id,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CityProvinceBase && other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
