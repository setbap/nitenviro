import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:nitenviro/pages/phone_number_login/phone_number_login.dart';

class IntroPage extends StatefulWidget {
  static const String path = "/intro";
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class IntroPageData {
  final Color backgroundColor;
  final Color textColor;
  final Color fillColor;
  final String text;
  final String path;
  IntroPageData({
    required this.backgroundColor,
    required this.textColor,
    required this.fillColor,
    required this.text,
    required this.path,
  });
}

List<IntroPageData> intropageData = [
  IntroPageData(
    backgroundColor: const Color(0xffD2FBE6),
    fillColor: const Color(0xff59B981),
    textColor: Colors.white,
    text: "Enviro",
    path: "assets/1.png",
  ),
  IntroPageData(
    backgroundColor: Colors.white,
    fillColor: const Color(0xFFFFD300),
    textColor: Colors.black,
    text: "ساختن جهانی بهتر",
    path: "assets/2.png",
  ),
  IntroPageData(
    backgroundColor: const Color(0xFFFBF4D2),
    fillColor: const Color(0xFFFFD300),
    textColor: Colors.white,
    text: "برای آینده",
    path: "assets/3.png",
  ),
];

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late IntroPageData _currentPage;
  late IntroPageData _secondPage;
  late IntroPageData _thirdPage;
  late IntroPageData _visible;

  late AnimationController _animationController;
  double _transitionPercent = 0.0;
  @override
  void initState() {
    _currentPage = intropageData[0];
    _secondPage = intropageData[1];
    _thirdPage = intropageData[2];
    _visible = _currentPage;

    _transitionPercent = 0.0;
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    )
      ..addListener(() {
        setState(() {
          _transitionPercent = _animationController.value;
        });
        if (_transitionPercent < 0.5) {
          _visible = _currentPage;
        } else {
          _visible = _secondPage;
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            currentIndex++;
            final pagesLen = intropageData.length;
            currentIndex = currentIndex % pagesLen;
            _currentPage = intropageData[currentIndex % pagesLen];
            final secondPageIndex = (currentIndex + 1) % pagesLen;
            _secondPage = intropageData[secondPageIndex];
            final thidPageIndex = (currentIndex + 2) % pagesLen;
            _thirdPage = intropageData[thidPageIndex];

            _animationController.value = 0;
            _transitionPercent = 0;
          });
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double offsetPercent = 1;
    if (_animationController.value < 0.10) {
      offsetPercent = 0;
    } else if (_animationController.value < 0.35) {
      offsetPercent =
          -Curves.easeInCubic.transform((_transitionPercent - 0.1) * 4);
    } else if (_animationController.value > 0.75) {
      offsetPercent = Curves.easeInExpo.transform((1 - _transitionPercent) * 4);
    }
    final transofrmX = 1000 * offsetPercent;
    final scaleVal = 0.6 + (0.4 * (1 - offsetPercent));

    return CustomPaint(
      painter: CircleTransitionPainter(
        backgroundColor: _currentPage.backgroundColor,
        fillColor: _visible.fillColor,
        currentColor: _secondPage.backgroundColor,
        nextCircleColor: _thirdPage.backgroundColor,
        transitionPercent: _transitionPercent,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.translationValues(transofrmX, 0, 0)
                ..scale(scaleVal, scaleVal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 20),
                  Flexible(
                    flex: 50,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(36),
                        child: Image.asset(_visible.path),
                      ),
                    ),
                  ),
                  const Spacer(flex: 10),
                  Text(
                    _visible.text,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: ui.FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 70),
                  GestureDetector(
                    onTap: () {
                      if (currentIndex == intropageData.length - 1) {
                        Navigator.pushReplacementNamed(
                            context, LoginPhoneNumber.path);
                      } else {
                        _animationController.forward(from: 0.0);
                      }
                    },
                    child: Container(
                      color: Colors.amber.withOpacity(0),
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const Spacer(flex: 45),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CircleTransitionPainter extends CustomPainter {
  CircleTransitionPainter({
    required Color backgroundColor,
    required Color fillColor,
    required Color currentColor,
    required Color nextCircleColor,
    this.transitionPercent = 0.0,
  })  : backgroundColorPainter = Paint()..color = backgroundColor,
        fillColorPainter = Paint()..color = fillColor,
        currentColorPainter = Paint()..color = currentColor,
        nextCircleColorPainter = Paint()..color = nextCircleColor;
  final Paint backgroundColorPainter;
  final Paint fillColorPainter;
  final Paint currentColorPainter;
  final Paint nextCircleColorPainter;
  final double transitionPercent;
  final baseRadius = 36.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (transitionPercent < 0.5) {
      final double expantionPercent = transitionPercent * 2;
      _drawExpantion(canvas, size, expantionPercent);
    } else {
      final double contractionPercent = (transitionPercent - 0.5) * 2;
      _drawContraction(canvas, size, contractionPercent);
    }

    var circlePercent = 1.0;
    if (transitionPercent < 0.25) {
      circlePercent = (0.25 - transitionPercent) * 4;
    } else {
      circlePercent = (transitionPercent - 0.75) * 4;
    }
    _drawAnimatedCircle(
      canvas,
      30,
      circlePercent,
      const Offset(0, 100),
      backgroundColorPainter.color,
      fillColorPainter.color,
      false,
    );
    _drawAnimatedCircle(
      canvas,
      60,
      circlePercent,
      Offset(0, size.height / 2),
      backgroundColorPainter.color,
      fillColorPainter.color,
      false,
    );
    _drawAnimatedCircle(
      canvas,
      100,
      circlePercent,
      Offset(size.width, size.height - 40),
      backgroundColorPainter.color,
      fillColorPainter.color,
      true,
    );
  }

  void _drawExpantion(ui.Canvas canvas, ui.Size size, double expantionPercent) {
    // max redius when page expand
    final double maxRadius = size.height * 200;

    // circle when animation not started
    final baseCircleCenter = Offset(size.width * 0.5, size.height * 0.76);

    // left bound when circle expanded
    final leftBound = baseCircleCenter.dx - baseRadius;

    final slowCircleGrow = pow(expantionPercent, 8);

    // ra
    final cucrrentRadius = (slowCircleGrow * maxRadius) + baseRadius;

    final cucrrentRadiusCenter = ui.Offset(
      leftBound + cucrrentRadius,
      baseCircleCenter.dy,
    );

    // paint background
    canvas.drawPaint(backgroundColorPainter);

    // paint circle

    canvas.drawCircle(
      cucrrentRadiusCenter,
      cucrrentRadius,
      currentColorPainter,
    );

    // paint arrow
    if (expantionPercent < 0.1) {
      _drawArrow(canvas, baseCircleCenter, fillColorPainter.color);
    }
  }

  void _drawContraction(
    ui.Canvas canvas,
    ui.Size size,
    double expantionPercent,
  ) {
    // max redius when page expand
    final double maxRadius = size.height * 200;

    // circle when animation not started
    final baseCircleCenter = Offset(size.width * 0.5, size.height * 0.76);

    final endingCircle = baseCircleCenter.dx - baseRadius;

    // right start when circle expanded
    final rightSideStarting = baseCircleCenter.dx + baseRadius;

    final easedEpantionPercent = Curves.easeInOut.transform(expantionPercent);
    final inversPercent = 1 - easedEpantionPercent;
    final slowCircleGrow = pow(inversPercent, 8);

    // ra
    final cucrrentRadius = (slowCircleGrow * maxRadius) + baseRadius;

    final circleCurrentRightSide =
        rightSideStarting + (endingCircle - rightSideStarting) * inversPercent;

    final currentCenterX = circleCurrentRightSide - cucrrentRadius;

    final cucrrentRadiusCenter = ui.Offset(
      currentCenterX,
      baseCircleCenter.dy,
    );

    // paint background
    canvas.drawPaint(currentColorPainter);

    // paint circle

    canvas.drawCircle(
      cucrrentRadiusCenter,
      cucrrentRadius,
      backgroundColorPainter,
    );

    if (expantionPercent > 0.9) {
      final nextCirclePercent = (expantionPercent - 0.9) * 10.1;
      canvas.drawCircle(
        baseCircleCenter,
        nextCirclePercent * baseRadius,
        nextCircleColorPainter,
      );
    }

    // paint arrow
    if (expantionPercent > 0.95) {
      _drawArrow(canvas, baseCircleCenter, fillColorPainter.color);
    }
  }

  void _drawAnimatedCircle(
    ui.Canvas canvas,
    double radius,
    double percent,
    ui.Offset circleCenter,
    Color color,
    Color fillColor,
    bool isToLeftOut,
  ) {
    final rect =
        Rect.fromCenter(center: circleCenter, width: radius, height: radius);

    canvas.drawCircle(
      circleCenter,
      radius * percent,
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

  void _drawArrow(ui.Canvas canvas, ui.Offset circleCenter, Color color) {
    final arrowIcon = Icons.arrow_forward_ios_sharp;
    final paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontFamily: arrowIcon.fontFamily,
        fontSize: 24,
        textAlign: TextAlign.center,
      ),
    )
      ..pushStyle(ui.TextStyle(color: color))
      ..addText(String.fromCharCode(arrowIcon.codePoint));

    final paragraph = paragraphBuilder.build()
      ..layout(
        ui.ParagraphConstraints(
          width: baseRadius,
        ),
      );
    canvas.drawParagraph(
      paragraph,
      circleCenter -
          Offset(
            baseRadius / 2,
            baseRadius / 4,
          ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
