class CollectedRubish implements Comparable {
  final DateTime collectedAt;

  final String driverDesc;
  final String imageUrl;
  final String address;
  final double lat;
  final double lng;
  final int plak;
  final int postalCode;
  final double? metal;
  final double? glass;
  final double? mix;
  final double? plastic;
  final double? paper;
  final bool isSpectial;

  CollectedRubish({
    required this.collectedAt,
    required this.driverDesc,
    required this.lat,
    required this.lng,
    required this.imageUrl,
    required this.address,
    required this.plak,
    required this.postalCode,
    required this.isSpectial,
    this.metal,
    this.glass,
    this.mix,
    this.plastic,
    this.paper,
  });

  @override
  int compareTo(other) {
    return collectedAt.compareTo(other.collectedAt);
  }
}
