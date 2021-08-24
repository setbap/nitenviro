import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

enum RoundRediusSide { top, bottom, all }

class SimpleLocation extends StatelessWidget {
  final LatLng latLng;
  final double radius;
  final RoundRediusSide side;

  const SimpleLocation({
    Key? key,
    required this.latLng,
    this.radius = 16,
    this.side = RoundRediusSide.all,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(side == RoundRediusSide.top ? 0 : radius),
          top: Radius.circular(side == RoundRediusSide.bottom ? 0 : radius),
        ),
        child: FlutterMap(
          options: MapOptions(
            center: latLng,
            zoom: 16,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: latLng,
                  builder: (ctx) => const Icon(
                    Icons.location_on_outlined,
                    color: Colors.redAccent,
                    size: 48,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
