import 'dart:convert';

import 'package:rubbish_collectors/rubbish_collectors.dart';

class SpacialRequest {
  final String id;
  final String buildingId;
  final Building building;
  final String userId;
  final BuildingUser? user;
  final String? driverId;
  final BuildingUser? driver;
  final String? driverMessage;
  final int status;
  final double glassWeight;
  final double metalWeight;
  final double paperWeight;
  final double plasticWeight;
  final double mixedWeight;
  final double allWeight;
  final String? driverDescription;
  final String? imageUrl;
  final bool isSpecial;
  final String? specialDescription;
  final String? specialImageUrl;
  final int? specialWeekDay;
  final DateTime? receivedTime;

  const SpacialRequest({
    required this.id,
    required this.buildingId,
    required this.building,
    required this.userId,
    required this.user,
    this.driverId,
    this.driver,
    this.driverMessage,
    this.receivedTime,
    required this.status,
    required this.glassWeight,
    required this.metalWeight,
    required this.paperWeight,
    required this.plasticWeight,
    required this.mixedWeight,
    required this.allWeight,
    required this.driverDescription,
    required this.imageUrl,
    required this.isSpecial,
    required this.specialDescription,
    required this.specialImageUrl,
    required this.specialWeekDay,
  });

  SpacialRequest copyWith(
      {String? id,
      String? buildingId,
      Building? building,
      String? userId,
      BuildingUser? user,
      String? driverId,
      BuildingUser? driver,
      String? driverMessage,
      int? status,
      double? glassWeight,
      double? metalWeight,
      double? paperWeight,
      double? plasticWeight,
      double? mixedWeight,
      double? allWeight,
      String? driverDescription,
      String? imageUrl,
      bool? isSpecial,
      String? specialDescription,
      String? specialImageUrl,
      int? specialWeekDay,
      DateTime? receivedTime}) {
    return SpacialRequest(
      id: id ?? this.id,
      receivedTime: receivedTime ?? this.receivedTime,
      buildingId: buildingId ?? this.buildingId,
      building: building ?? this.building,
      userId: userId ?? this.userId,
      user: user ?? this.user,
      driverId: driverId ?? this.driverId,
      driver: driver ?? this.driver,
      driverMessage: driverMessage ?? this.driverMessage,
      status: status ?? this.status,
      glassWeight: glassWeight ?? this.glassWeight,
      metalWeight: metalWeight ?? this.metalWeight,
      paperWeight: paperWeight ?? this.paperWeight,
      plasticWeight: plasticWeight ?? this.plasticWeight,
      mixedWeight: mixedWeight ?? this.mixedWeight,
      allWeight: allWeight ?? this.allWeight,
      driverDescription: driverDescription ?? this.driverDescription,
      imageUrl: imageUrl ?? this.imageUrl,
      isSpecial: isSpecial ?? this.isSpecial,
      specialDescription: specialDescription ?? this.specialDescription,
      specialImageUrl: specialImageUrl ?? this.specialImageUrl,
      specialWeekDay: specialWeekDay ?? this.specialWeekDay,
    );
  }

  factory SpacialRequest.fromMap(Map<String, dynamic> map) {
    return SpacialRequest(
      id: map['id'],
      buildingId: map['buildingId'],
      receivedTime: map['receivedTime'] == null
          ? null
          : DateTime.parse(map['receivedTime']),
      building: Building.fromMap(map['building']),
      userId: map['userId'],
      user: map['user'] == null ? null : BuildingUser.fromMap(map['user']),
      driverId: map['driverId'],
      driver: map['driver'] == null || map['driver']['phone'] == null
          ? null
          : BuildingUser.fromMap(map['driver']),
      driverMessage: map['driverMessage'],
      status: map['status'],
      glassWeight: map['glassWeight'] is int
          ? (map['glassWeight'] as int).toDouble()
          : map['glassWeight'],
      metalWeight: map['metalWeight'] is int
          ? (map['metalWeight'] as int).toDouble()
          : map['metalWeight'],
      paperWeight: map['paperWeight'] is int
          ? (map['paperWeight'] as int).toDouble()
          : map['paperWeight'],
      plasticWeight: map['plasticWeight'] is int
          ? (map['plasticWeight'] as int).toDouble()
          : map['plasticWeight'],
      mixedWeight: map['mixedWeight'] is int
          ? (map['mixedWeight'] as int).toDouble()
          : map['mixedWeight'],
      allWeight: map['allWeight'] is int
          ? (map['allWeight'] as int).toDouble()
          : map['allWeight'],
      driverDescription: map['driverDescription'],
      imageUrl: map['imageUrl'],
      isSpecial: map['isSpecial'],
      specialDescription: map['specialDescription'],
      specialImageUrl: map['specialImageUrl'],
      specialWeekDay: map['specialWeekDay'],
    );
  }

  factory SpacialRequest.fromJson(String source) =>
      SpacialRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SpacialRequest(id: $id, buildingId: $buildingId, building: $building, userId: $userId, user: $user, driverId: $driverId, driver: $driver, driverMessage: $driverMessage, status: $status, glassWeight: $glassWeight, metalWeight: $metalWeight, paperWeight: $paperWeight, plasticWeight: $plasticWeight, mixedWeight: $mixedWeight, allWeight: $allWeight, driverDescription: $driverDescription, imageUrl: $imageUrl, isSpecial: $isSpecial, specialDescription: $specialDescription, specialImageUrl: $specialImageUrl, specialWeekDay: $specialWeekDay)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpacialRequest &&
        other.id == id &&
        other.buildingId == buildingId &&
        other.building == building &&
        other.userId == userId &&
        other.user == user &&
        other.driverId == driverId &&
        other.driver == driver &&
        other.driverMessage == driverMessage &&
        other.status == status &&
        other.glassWeight == glassWeight &&
        other.metalWeight == metalWeight &&
        other.paperWeight == paperWeight &&
        other.plasticWeight == plasticWeight &&
        other.mixedWeight == mixedWeight &&
        other.allWeight == allWeight &&
        other.driverDescription == driverDescription &&
        other.imageUrl == imageUrl &&
        other.isSpecial == isSpecial &&
        other.specialDescription == specialDescription &&
        other.specialImageUrl == specialImageUrl &&
        other.specialWeekDay == specialWeekDay;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        buildingId.hashCode ^
        building.hashCode ^
        userId.hashCode ^
        user.hashCode ^
        driverId.hashCode ^
        driver.hashCode ^
        driverMessage.hashCode ^
        status.hashCode ^
        glassWeight.hashCode ^
        metalWeight.hashCode ^
        paperWeight.hashCode ^
        plasticWeight.hashCode ^
        mixedWeight.hashCode ^
        allWeight.hashCode ^
        driverDescription.hashCode ^
        imageUrl.hashCode ^
        isSpecial.hashCode ^
        specialDescription.hashCode ^
        specialImageUrl.hashCode ^
        specialWeekDay.hashCode;
  }
}
