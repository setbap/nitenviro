export 'city_result.dart';
export 'generic_result.dart';
export 'login_result.dart';
export 'province_result.dart';
export 'send_code_result.dart';
export 'user_result.dart';
export 'user_with_token.dart';

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
