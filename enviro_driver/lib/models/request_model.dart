class DriverLocationData {
  final double lat;
  final double lng;
  final bool loading;
  final String errror;

  const DriverLocationData({
    required this.lat,
    required this.lng,
    required this.loading,
    required this.errror,
  });

  DriverLocationData copyWith({
    double? lat,
    double? lng,
    bool? loading,
    String? errror,
  }) {
    return DriverLocationData(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      loading: loading ?? this.loading,
      errror: errror ?? this.errror,
    );
  }
}
