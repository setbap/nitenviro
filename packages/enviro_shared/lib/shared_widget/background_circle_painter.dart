import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:enviro_shared/utils/colors.dart';

typedef CirclePaintFn = List<CirclePaintInfo> Function(Size size);

class BackgroundCirclePainter extends StatelessWidget {
  final Widget child;
  final CirclePaintFn circlesPainter;

  const BackgroundCirclePainter({
    Key? key,
    required this.child,
    required this.circlesPainter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: child,
      painter: BackgroundPainter(circlesPainter: circlesPainter),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final CirclePaintFn circlesPainter;

  const BackgroundPainter({required this.circlesPainter});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.white);
    for (var element in circlesPainter(size)) {
      _drawCircle(
        canvas,
        element.radius,
        element.center,
        mainYellow,
        lightYellow,
        element.isRightPrimary,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawCircle(
    ui.Canvas canvas,
    double radius,
    ui.Offset circleCenter,
    Color color,
    Color fillColor,
    bool isToLeftOut,
  ) {
    final rect =
        Rect.fromCenter(center: circleCenter, width: radius, height: radius);

    canvas.drawCircle(
      circleCenter,
      radius,
      Paint()
        ..color = color
        ..shader = LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          stops: const [0, 2],
          colors: [
            isToLeftOut ? color : fillColor,
            isToLeftOut ? fillColor : color,
          ],
        ).createShader(rect),
    );
  }
}

class CirclePaintInfo {
  final double radius;
  final Offset center;
  final bool isRightPrimary;

  const CirclePaintInfo({
    required this.radius,
    required this.center,
    this.isRightPrimary = true,
  });
}
