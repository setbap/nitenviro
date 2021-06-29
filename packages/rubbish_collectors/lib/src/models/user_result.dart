class UserInfoResult {
  final int id;
  final String phone;
  final String? name;
  final String? email;
  final String? avatarUrl;
  final int credit;
  final int? type;
  final bool? isActive;
  final String createdAt;
  final String now;

  UserInfoResult({
    required this.id,
    required this.phone,
    this.name,
    this.email,
    this.avatarUrl,
    this.credit = 0,
    this.type,
    this.isActive,
    required this.createdAt,
  }) : now = DateTime.now().toIso8601String();

  factory UserInfoResult.fromJson(Map<String, dynamic> map) {
    return UserInfoResult(
      id: map['id'],
      phone: map['phone'],
      name: map['name'],
      email: map['email'],
      avatarUrl: map['avatarUrl'],
      credit: map['credit'],
      type: map['type'],
      isActive: map['isActive'],
      createdAt: map['createdAt'],
    );
  }
}
