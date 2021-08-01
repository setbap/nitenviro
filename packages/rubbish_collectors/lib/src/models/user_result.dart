import 'package:rubbish_collectors/src/models/building.dart';

class UserInfoResult {
  final String id;
  final String phone;
  final String name;
  final String email;
  final String avatarUrl;
  final int credit;
  final int? type;
  final bool? isActive;
  final String createdAt;
  final List<Building> buildings;

  UserInfoResult({
    required this.id,
    required this.phone,
    this.name = "",
    this.email = "",
    this.avatarUrl = "",
    this.credit = 0,
    this.type,
    this.isActive,
    required this.buildings,
    required this.createdAt,
  });

  factory UserInfoResult.fromJson(Map<String, dynamic> map) {
    return UserInfoResult(
      id: map['id'] as String,
      phone: map['phone'] as String,
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      avatarUrl: map['avatar'] ?? "",
      credit: map['credit'] as int,
      type: map['type'] as int,
      isActive: map['isActive'] as bool,
      createdAt: map['createdAt'] as String,
      buildings: (map['buildings'] as List<dynamic>).map<Building>((b) {
        return Building.fromMap(b);
      }).toList(),
    );
  }
}
