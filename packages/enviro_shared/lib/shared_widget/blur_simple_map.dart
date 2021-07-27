import 'dart:ui';
import 'package:latlong2/latlong.dart';
import 'package:enviro_shared/shared_widget/shared_widget.dart';
import 'package:flutter/cupertino.dart';

class BluredSimpleMap extends StatefulWidget {
  final double lat;
  final double lng;
  const BluredSimpleMap({
    Key? key,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  @override
  State<BluredSimpleMap> createState() => _BluredSimpleMapState();
}

class _BluredSimpleMapState extends State<BluredSimpleMap>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween<double>(begin: 0, end: 5).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) => BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: animation.value,
              sigmaY: animation.value,
            ),
            child: child,
          ),
          child: const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Hero(
                tag: "main_simple_map_hero",
                child: SimpleLocation(
                  key: const ValueKey("locationKey"),
                  latLng: LatLng(widget.lat, widget.lng),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
