import 'dart:ui';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/pages/new_request/widgets/simple_location.dart';

class SimpleMapDialog extends StatefulWidget {
  final LatLng latLng;
  const SimpleMapDialog({
    Key? key,
    required this.latLng,
  }) : super(key: key);

  @override
  State<SimpleMapDialog> createState() => _SimpleMapDialogState();
}

class _SimpleMapDialogState extends State<SimpleMapDialog>
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
                  latLng: widget.latLng,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
