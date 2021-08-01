import 'dart:convert';

class Building {
  final String id;
  final String name;
  final String createdAt;
  final String address;
  final double latitude;
  final double longitude;
  final int plaque;
  final String postalCode;
  final String? description;
  final int weekDay;
  final String weekDayPersian;
  final int timeOfDay;
  final String timeOfDayPersian;
  final String cityId;
  final String cityName;
  Building({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.plaque,
    required this.postalCode,
    this.description,
    required this.weekDay,
    required this.weekDayPersian,
    required this.timeOfDay,
    required this.timeOfDayPersian,
    required this.cityId,
    required this.cityName,
  });

  Building copyWith({
    String? id,
    String? name,
    String? createdAt,
    String? address,
    double? latitude,
    double? longitude,
    int? plaque,
    String? postalCode,
    String? description,
    int? weekDay,
    String? weekDayPersian,
    int? timeOfDay,
    String? timeOfDayPersian,
    String? cityId,
    String? cityName,
  }) {
    return Building(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      plaque: plaque ?? this.plaque,
      postalCode: postalCode ?? this.postalCode,
      description: description ?? this.description,
      weekDay: weekDay ?? this.weekDay,
      weekDayPersian: weekDayPersian ?? this.weekDayPersian,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      timeOfDayPersian: timeOfDayPersian ?? this.timeOfDayPersian,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'plaque': plaque,
      'postalCode': postalCode,
      'description': description,
      'weekDay': weekDay,
      'weekDayPersian': weekDayPersian,
      'timeOfDay': timeOfDay,
      'timeOfDayPersian': timeOfDayPersian,
      'cityId': cityId,
      'cityName': cityName,
    };
  }

  factory Building.fromMap(Map<String, dynamic> map) {
    return Building(
      id: map['id'],
      name: map['name'],
      createdAt: map['createdAt'],
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      plaque: map['plaque'],
      postalCode: map['postalCode'],
      description: map['description'],
      weekDay: map['weekDay'],
      weekDayPersian: map['weekDayPersian'],
      timeOfDay: map['timeOfDay'],
      timeOfDayPersian: map['timeOfDayPersian'],
      cityId: map['cityId'],
      cityName: map['cityName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Building.fromJson(String source) =>
      Building.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Building(id: $id, name: $name, createdAt: $createdAt, address: $address, latitude: $latitude, longitude: $longitude, plaque: $plaque, postalCode: $postalCode, description: $description, weekDay: $weekDay, weekDayPersian: $weekDayPersian, timeOfDay: $timeOfDay, timeOfDayPersian: $timeOfDayPersian, cityId: $cityId, cityName: $cityName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Building &&
        other.id == id &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.address == address &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.plaque == plaque &&
        other.postalCode == postalCode &&
        other.description == description &&
        other.weekDay == weekDay &&
        other.weekDayPersian == weekDayPersian &&
        other.timeOfDay == timeOfDay &&
        other.timeOfDayPersian == timeOfDayPersian &&
        other.cityId == cityId &&
        other.cityName == cityName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        createdAt.hashCode ^
        address.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        plaque.hashCode ^
        postalCode.hashCode ^
        description.hashCode ^
        weekDay.hashCode ^
        weekDayPersian.hashCode ^
        timeOfDay.hashCode ^
        timeOfDayPersian.hashCode ^
        cityId.hashCode ^
        cityName.hashCode;
  }
}

class BuildingCreateModel {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final int plaque;
  final String postalCode;
  final String description;
  final int weekDay;
  final int timeOfDay;
  final String cityId;

  const BuildingCreateModel({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.plaque,
    required this.postalCode,
    required this.description,
    required this.weekDay,
    required this.timeOfDay,
    required this.cityId,
  });

  BuildingCreateModel copyWith({
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    int? plaque,
    String? postalCode,
    String? description,
    int? weekDay,
    int? timeOfDay,
    String? cityId,
  }) {
    return BuildingCreateModel(
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      plaque: plaque ?? this.plaque,
      postalCode: postalCode ?? this.postalCode,
      description: description ?? this.description,
      weekDay: weekDay ?? this.weekDay,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      cityId: cityId ?? this.cityId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'plaque': plaque,
      'postalCode': postalCode,
      'description': description,
      'weekDay': weekDay,
      'timeOfDay': timeOfDay,
      'cityId': cityId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'BuildingCreateModel(name: $name, address: $address, latitude: $latitude, longitude: $longitude, plaque: $plaque, postalCode: $postalCode, description: $description, weekDay: $weekDay, timeOfDay: $timeOfDay, cityId: $cityId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BuildingCreateModel &&
        other.name == name &&
        other.address == address &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.plaque == plaque &&
        other.postalCode == postalCode &&
        other.description == description &&
        other.weekDay == weekDay &&
        other.timeOfDay == timeOfDay &&
        other.cityId == cityId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        address.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        plaque.hashCode ^
        postalCode.hashCode ^
        description.hashCode ^
        weekDay.hashCode ^
        timeOfDay.hashCode ^
        cityId.hashCode;
  }
}
