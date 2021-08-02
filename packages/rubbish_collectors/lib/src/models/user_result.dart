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
    List<Building> buildings = [];
    try {
      buildings = (map['buildings'] as List<dynamic>).map<Building>((b) {
        return Building.fromMap(b);
      }).toList();
    } catch (e) {}
    map["building"] = map["building"] == null ? [] : map["building"];
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
      buildings: buildings,
    );
  }

  UserInfoResult copyWith({
    String? id,
    String? phone,
    String? name,
    String? email,
    String? avatarUrl,
    int? credit,
    int? type,
    bool? isActive,
    String? createdAt,
    List<Building>? buildings,
  }) {
    return UserInfoResult(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      credit: credit ?? this.credit,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      buildings: buildings ?? this.buildings,
    );
  }
}
