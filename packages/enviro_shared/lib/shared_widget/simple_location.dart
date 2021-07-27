import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SimpleLocation extends StatelessWidget {
  final LatLng latLng;
  final double radius;

  const SimpleLocation({
    Key? key,
    required this.latLng,
    this.radius = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: FlutterMap(
          options: MapOptions(
            center: latLng,
            zoom: 13.0,
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
