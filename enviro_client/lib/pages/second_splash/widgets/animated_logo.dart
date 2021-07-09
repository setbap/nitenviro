import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:nitenviro/utils/utils.dart';

class AnimatedPathPainter extends CustomPainter {
  final Animation<double> _animation;

  AnimatedPathPainter(this._animation) : super(repaint: _animation);

  List<Path> _createAnyPath(Size size) {
    final paths = <Path>[];

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.1373626);
    path_0.cubicTo(0, size.height * 0.06149931, size.width * 0.06124692, 0,
        size.width * 0.1367989, 0);
    path_0.lineTo(size.width * 0.8632011, 0);
    path_0.cubicTo(size.width * 0.9387524, 0, size.width,
        size.height * 0.06149931, size.width, size.height * 0.1373626);
    path_0.lineTo(size.width, size.height * 0.8626374);
    path_0.cubicTo(size.width, size.height * 0.9385000, size.width * 0.9387524,
        size.height, size.width * 0.8632011, size.height);
    path_0.lineTo(size.width * 0.1367989, size.height);
    path_0.cubicTo(size.width * 0.06124692, size.height, 0,
        size.height * 0.9385000, 0, size.height * 0.8626374);
    path_0.lineTo(0, size.height * 0.1373626);
    path_0.close();

    paths.add(path_0);

    Path path_1 = Path();
    path_1.moveTo(0, size.height * 0.1373626);
    path_1.cubicTo(0, size.height * 0.06149931, size.width * 0.06124692, 0,
        size.width * 0.1367989, 0);
    path_1.lineTo(size.width * 0.8632011, 0);
    path_1.cubicTo(size.width * 0.9387524, 0, size.width,
        size.height * 0.06149931, size.width, size.height * 0.1373626);
    path_1.lineTo(size.width, size.height * 0.8626374);
    path_1.cubicTo(size.width, size.height * 0.9385000, size.width * 0.9387524,
        size.height, size.width * 0.8632011, size.height);
    path_1.lineTo(size.width * 0.1367989, size.height);
    path_1.cubicTo(size.width * 0.06124692, size.height, 0,
        size.height * 0.9385000, 0, size.height * 0.8626374);
    path_1.lineTo(0, size.height * 0.1373626);
    path_1.close();

    paths.add(path_1);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.4493228, size.height * 0.1569973);
    path_2.lineTo(size.width * 0.4493228, size.height * 0.3991635);
    path_2.lineTo(size.width * 0.6238030, size.height * 0.3328255);
    path_2.lineTo(size.width * 0.6238030, size.height * 0.09065934);
    path_2.lineTo(size.width * 0.4493228, size.height * 0.1569973);
    path_2.close();
    path_2.moveTo(size.width * 0.3734610, size.height * 0.1515989);
    path_2.lineTo(size.width * 0.4000123, size.height * 0.1662747);
    path_2.lineTo(size.width * 0.4000123, size.height * 0.7076676);
    path_2.lineTo(size.width * 0.3734610, size.height * 0.6903791);
    path_2.lineTo(size.width * 0.3734610, size.height * 0.1515989);
    path_2.close();
    path_2.moveTo(size.width * 0.4493228, size.height * 0.7076676);
    path_2.lineTo(size.width * 0.4493228, size.height * 0.4655014);
    path_2.lineTo(size.width * 0.6238030, size.height * 0.3991635);
    path_2.lineTo(size.width * 0.6238030, size.height * 0.6413283);
    path_2.lineTo(size.width * 0.4493228, size.height * 0.7076676);
    path_2.close();

    paths.add(path_2);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.4044364, size.height * 0.8551978);
    path_3.lineTo(size.width * 0.3751956, size.height * 0.8551978);
    path_3.lineTo(size.width * 0.3751956, size.height * 0.8750783);
    path_3.lineTo(size.width * 0.4095130, size.height * 0.8750783);
    path_3.lineTo(size.width * 0.4095130, size.height * 0.8873626);
    path_3.lineTo(size.width * 0.3599658, size.height * 0.8873626);
    path_3.lineTo(size.width * 0.3599658, size.height * 0.8131442);
    path_3.lineTo(size.width * 0.4094104, size.height * 0.8131442);
    path_3.lineTo(size.width * 0.4094104, size.height * 0.8255302);
    path_3.lineTo(size.width * 0.3751956, size.height * 0.8255302);
    path_3.lineTo(size.width * 0.3751956, size.height * 0.8432184);
    path_3.lineTo(size.width * 0.4044364, size.height * 0.8432184);
    path_3.lineTo(size.width * 0.4044364, size.height * 0.8551978);
    path_3.close();
    path_3.moveTo(size.width * 0.4309863, size.height * 0.8322088);
    path_3.lineTo(size.width * 0.4314432, size.height * 0.8385797);
    path_3.cubicTo(
        size.width * 0.4353694,
        size.height * 0.8336525,
        size.width * 0.4406320,
        size.height * 0.8311882,
        size.width * 0.4472312,
        size.height * 0.8311882);
    path_3.cubicTo(
        size.width * 0.4530520,
        size.height * 0.8311882,
        size.width * 0.4573844,
        size.height * 0.8329052,
        size.width * 0.4602271,
        size.height * 0.8363379);
    path_3.cubicTo(
        size.width * 0.4630698,
        size.height * 0.8397692,
        size.width * 0.4645253,
        size.height * 0.8449011,
        size.width * 0.4645923,
        size.height * 0.8517321);
    path_3.lineTo(size.width * 0.4645923, size.height * 0.8873626);
    path_3.lineTo(size.width * 0.4499220, size.height * 0.8873626);
    path_3.lineTo(size.width * 0.4499220, size.height * 0.8520879);
    path_3.cubicTo(
        size.width * 0.4499220,
        size.height * 0.8489615,
        size.width * 0.4492449,
        size.height * 0.8467019,
        size.width * 0.4478906,
        size.height * 0.8453091);
    path_3.cubicTo(
        size.width * 0.4465376,
        size.height * 0.8438819,
        size.width * 0.4442859,
        size.height * 0.8431676,
        size.width * 0.4411395,
        size.height * 0.8431676);
    path_3.cubicTo(
        size.width * 0.4370096,
        size.height * 0.8431676,
        size.width * 0.4339138,
        size.height * 0.8449354,
        size.width * 0.4318495,
        size.height * 0.8484698);
    path_3.lineTo(size.width * 0.4318495, size.height * 0.8873626);
    path_3.lineTo(size.width * 0.4171778, size.height * 0.8873626);
    path_3.lineTo(size.width * 0.4171778, size.height * 0.8322088);
    path_3.lineTo(size.width * 0.4309863, size.height * 0.8322088);
    path_3.close();
    path_3.moveTo(size.width * 0.4963215, size.height * 0.8693681);
    path_3.lineTo(size.width * 0.5065253, size.height * 0.8322088);
    path_3.lineTo(size.width * 0.5218564, size.height * 0.8322088);
    path_3.lineTo(size.width * 0.5033269, size.height * 0.8873626);
    path_3.lineTo(size.width * 0.4893146, size.height * 0.8873626);
    path_3.lineTo(size.width * 0.4707866, size.height * 0.8322088);
    path_3.lineTo(size.width * 0.4861176, size.height * 0.8322088);
    path_3.lineTo(size.width * 0.4963215, size.height * 0.8693681);
    path_3.close();
    path_3.moveTo(size.width * 0.5438372, size.height * 0.8873626);
    path_3.lineTo(size.width * 0.5291149, size.height * 0.8873626);
    path_3.lineTo(size.width * 0.5291149, size.height * 0.8322088);
    path_3.lineTo(size.width * 0.5438372, size.height * 0.8322088);
    path_3.lineTo(size.width * 0.5438372, size.height * 0.8873626);
    path_3.close();
    path_3.moveTo(size.width * 0.5282517, size.height * 0.8179354);
    path_3.cubicTo(
        size.width * 0.5282517,
        size.height * 0.8157266,
        size.width * 0.5289795,
        size.height * 0.8139080,
        size.width * 0.5304350,
        size.height * 0.8124808);
    path_3.cubicTo(
        size.width * 0.5319248,
        size.height * 0.8110536,
        size.width * 0.5339384,
        size.height * 0.8103407,
        size.width * 0.5364761,
        size.height * 0.8103407);
    path_3.cubicTo(
        size.width * 0.5389808,
        size.height * 0.8103407,
        size.width * 0.5409767,
        size.height * 0.8110536,
        size.width * 0.5424665,
        size.height * 0.8124808);
    path_3.cubicTo(
        size.width * 0.5439562,
        size.height * 0.8139080,
        size.width * 0.5447004,
        size.height * 0.8157266,
        size.width * 0.5447004,
        size.height * 0.8179354);
    path_3.cubicTo(
        size.width * 0.5447004,
        size.height * 0.8201786,
        size.width * 0.5439384,
        size.height * 0.8220137,
        size.width * 0.5424159,
        size.height * 0.8234409);
    path_3.cubicTo(
        size.width * 0.5409261,
        size.height * 0.8248681,
        size.width * 0.5389466,
        size.height * 0.8255810,
        size.width * 0.5364761,
        size.height * 0.8255810);
    path_3.cubicTo(
        size.width * 0.5340055,
        size.height * 0.8255810,
        size.width * 0.5320082,
        size.height * 0.8248681,
        size.width * 0.5304856,
        size.height * 0.8234409);
    path_3.cubicTo(
        size.width * 0.5289973,
        size.height * 0.8220137,
        size.width * 0.5282517,
        size.height * 0.8201786,
        size.width * 0.5282517,
        size.height * 0.8179354);
    path_3.close();
    path_3.moveTo(size.width * 0.5868358, size.height * 0.8460220);
    path_3.cubicTo(
        size.width * 0.5848386,
        size.height * 0.8457500,
        size.width * 0.5830780,
        size.height * 0.8456140,
        size.width * 0.5815554,
        size.height * 0.8456140);
    path_3.cubicTo(
        size.width * 0.5760055,
        size.height * 0.8456140,
        size.width * 0.5723666,
        size.height * 0.8475000,
        size.width * 0.5706416,
        size.height * 0.8512734);
    path_3.lineTo(size.width * 0.5706416, size.height * 0.8873626);
    path_3.lineTo(size.width * 0.5559699, size.height * 0.8873626);
    path_3.lineTo(size.width * 0.5559699, size.height * 0.8322088);
    path_3.lineTo(size.width * 0.5698290, size.height * 0.8322088);
    path_3.lineTo(size.width * 0.5702353, size.height * 0.8387843);
    path_3.cubicTo(
        size.width * 0.5731792,
        size.height * 0.8337212,
        size.width * 0.5772572,
        size.height * 0.8311882,
        size.width * 0.5824692,
        size.height * 0.8311882);
    path_3.cubicTo(
        size.width * 0.5840944,
        size.height * 0.8311882,
        size.width * 0.5856170,
        size.height * 0.8314093,
        size.width * 0.5870383,
        size.height * 0.8318516);
    path_3.lineTo(size.width * 0.5868358, size.height * 0.8460220);
    path_3.close();
    path_3.moveTo(size.width * 0.5898304, size.height * 0.8592761);
    path_3.cubicTo(
        size.width * 0.5898304,
        size.height * 0.8538049,
        size.width * 0.5908796,
        size.height * 0.8489286,
        size.width * 0.5929781,
        size.height * 0.8446456);
    path_3.cubicTo(
        size.width * 0.5950766,
        size.height * 0.8403640,
        size.width * 0.5980876,
        size.height * 0.8370508,
        size.width * 0.6020137,
        size.height * 0.8347060);
    path_3.cubicTo(
        size.width * 0.6059740,
        size.height * 0.8323613,
        size.width * 0.6105595,
        size.height * 0.8311882,
        size.width * 0.6157715,
        size.height * 0.8311882);
    path_3.cubicTo(
        size.width * 0.6231833,
        size.height * 0.8311882,
        size.width * 0.6292244,
        size.height * 0.8334657,
        size.width * 0.6338947,
        size.height * 0.8380192);
    path_3.cubicTo(
        size.width * 0.6385992,
        size.height * 0.8425728,
        size.width * 0.6412216,
        size.height * 0.8487582,
        size.width * 0.6417633,
        size.height * 0.8565742);
    path_3.lineTo(size.width * 0.6418646, size.height * 0.8603462);
    path_3.cubicTo(
        size.width * 0.6418646,
        size.height * 0.8688077,
        size.width * 0.6395130,
        size.height * 0.8756044,
        size.width * 0.6348085,
        size.height * 0.8807363);
    path_3.cubicTo(
        size.width * 0.6301040,
        size.height * 0.8858338,
        size.width * 0.6237921,
        size.height * 0.8883819,
        size.width * 0.6158728,
        size.height * 0.8883819);
    path_3.cubicTo(
        size.width * 0.6079535,
        size.height * 0.8883819,
        size.width * 0.6016252,
        size.height * 0.8858338,
        size.width * 0.5968865,
        size.height * 0.8807363);
    path_3.cubicTo(
        size.width * 0.5921819,
        size.height * 0.8756387,
        size.width * 0.5898304,
        size.height * 0.8687060,
        size.width * 0.5898304,
        size.height * 0.8599382);
    path_3.lineTo(size.width * 0.5898304, size.height * 0.8592761);
    path_3.close();
    path_3.moveTo(size.width * 0.6045021, size.height * 0.8603462);
    path_3.cubicTo(
        size.width * 0.6045021,
        size.height * 0.8655797,
        size.width * 0.6054829,
        size.height * 0.8695893,
        size.width * 0.6074460,
        size.height * 0.8723764);
    path_3.cubicTo(
        size.width * 0.6094090,
        size.height * 0.8751291,
        size.width * 0.6122175,
        size.height * 0.8765055,
        size.width * 0.6158728,
        size.height * 0.8765055);
    path_3.cubicTo(
        size.width * 0.6194268,
        size.height * 0.8765055,
        size.width * 0.6222011,
        size.height * 0.8751456,
        size.width * 0.6241984,
        size.height * 0.8724272);
    path_3.cubicTo(
        size.width * 0.6261956,
        size.height * 0.8696745,
        size.width * 0.6271943,
        size.height * 0.8652912,
        size.width * 0.6271943,
        size.height * 0.8592761);
    path_3.cubicTo(
        size.width * 0.6271943,
        size.height * 0.8541442,
        size.width * 0.6261956,
        size.height * 0.8501690,
        size.width * 0.6241984,
        size.height * 0.8473475);
    path_3.cubicTo(
        size.width * 0.6222011,
        size.height * 0.8445275,
        size.width * 0.6193926,
        size.height * 0.8431168,
        size.width * 0.6157715,
        size.height * 0.8431168);
    path_3.cubicTo(
        size.width * 0.6121847,
        size.height * 0.8431168,
        size.width * 0.6094090,
        size.height * 0.8445275,
        size.width * 0.6074460,
        size.height * 0.8473475);
    path_3.cubicTo(
        size.width * 0.6054829,
        size.height * 0.8501346,
        size.width * 0.6045021,
        size.height * 0.8544670,
        size.width * 0.6045021,
        size.height * 0.8603462);
    path_3.close();

    paths.add(path_3);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.1367989, size.height * 0.02335165);
    path_4.lineTo(size.width * 0.8632011, size.height * 0.02335165);
    path_4.lineTo(size.width * 0.8632011, size.height * -0.02335165);
    path_4.lineTo(size.width * 0.1367989, size.height * -0.02335165);
    path_4.lineTo(size.width * 0.1367989, size.height * 0.02335165);
    path_4.close();
    path_4.moveTo(size.width * 0.9767442, size.height * 0.1373626);
    path_4.lineTo(size.width * 0.9767442, size.height * 0.8626374);
    path_4.lineTo(size.width * 1.023256, size.height * 0.8626374);
    path_4.lineTo(size.width * 1.023256, size.height * 0.1373626);
    path_4.lineTo(size.width * 0.9767442, size.height * 0.1373626);
    path_4.close();
    path_4.moveTo(size.width * 0.8632011, size.height * 0.9766484);
    path_4.lineTo(size.width * 0.1367989, size.height * 0.9766484);
    path_4.lineTo(size.width * 0.1367989, size.height * 1.023352);
    path_4.lineTo(size.width * 0.8632011, size.height * 1.023352);
    path_4.lineTo(size.width * 0.8632011, size.height * 0.9766484);
    path_4.close();
    path_4.moveTo(size.width * 0.02325581, size.height * 0.8626374);
    path_4.lineTo(size.width * 0.02325581, size.height * 0.1373626);
    path_4.lineTo(size.width * -0.02325581, size.height * 0.1373626);
    path_4.lineTo(size.width * -0.02325581, size.height * 0.8626374);
    path_4.lineTo(size.width * 0.02325581, size.height * 0.8626374);
    path_4.close();
    path_4.moveTo(size.width * 0.1367989, size.height * 0.9766484);
    path_4.cubicTo(
        size.width * 0.07409083,
        size.height * 0.9766484,
        size.width * 0.02325581,
        size.height * 0.9256044,
        size.width * 0.02325581,
        size.height * 0.8626374);
    path_4.lineTo(size.width * -0.02325581, size.height * 0.8626374);
    path_4.cubicTo(
        size.width * -0.02325581,
        size.height * 0.9513970,
        size.width * 0.04840315,
        size.height * 1.023352,
        size.width * 0.1367989,
        size.height * 1.023352);
    path_4.lineTo(size.width * 0.1367989, size.height * 0.9766484);
    path_4.close();
    path_4.moveTo(size.width * 0.9767442, size.height * 0.8626374);
    path_4.cubicTo(
        size.width * 0.9767442,
        size.height * 0.9256044,
        size.width * 0.9259097,
        size.height * 0.9766484,
        size.width * 0.8632011,
        size.height * 0.9766484);
    path_4.lineTo(size.width * 0.8632011, size.height * 1.023352);
    path_4.cubicTo(
        size.width * 0.9515964,
        size.height * 1.023352,
        size.width * 1.023256,
        size.height * 0.9513970,
        size.width * 1.023256,
        size.height * 0.8626374);
    path_4.lineTo(size.width * 0.9767442, size.height * 0.8626374);
    path_4.close();
    path_4.moveTo(size.width * 0.8632011, size.height * 0.02335165);
    path_4.cubicTo(
        size.width * 0.9259097,
        size.height * 0.02335165,
        size.width * 0.9767442,
        size.height * 0.07439615,
        size.width * 0.9767442,
        size.height * 0.1373626);
    path_4.lineTo(size.width * 1.023256, size.height * 0.1373626);
    path_4.cubicTo(
        size.width * 1.023256,
        size.height * 0.04860261,
        size.width * 0.9515964,
        size.height * -0.02335165,
        size.width * 0.8632011,
        size.height * -0.02335165);
    path_4.lineTo(size.width * 0.8632011, size.height * 0.02335165);
    path_4.close();
    path_4.moveTo(size.width * 0.1367989, size.height * -0.02335165);
    path_4.cubicTo(
        size.width * 0.04840315,
        size.height * -0.02335165,
        size.width * -0.02325581,
        size.height * 0.04860261,
        size.width * -0.02325581,
        size.height * 0.1373626);
    path_4.lineTo(size.width * 0.02325581, size.height * 0.1373626);
    path_4.cubicTo(
        size.width * 0.02325581,
        size.height * 0.07439615,
        size.width * 0.07409083,
        size.height * 0.02335165,
        size.width * 0.1367989,
        size.height * 0.02335165);
    path_4.lineTo(size.width * 0.1367989, size.height * -0.02335165);
    path_4.close();

    paths.add(path_4);

    return paths;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final animationPercent = _animation.value;

    final pathes = _createAnyPath(size);

    final path_0 = createAnimatedPath(pathes[0], animationPercent);
    Paint paintFill = Paint()..style = PaintingStyle.stroke;
    paintFill.color = const Color(0xff4ADA63).withOpacity(0.0);
    canvas.drawPath(path_0, paintFill);

    final path_1 = createAnimatedPath(pathes[1], animationPercent);
    paintFill = Paint()..style = PaintingStyle.stroke;
    paintFill.color = lightBorder;
    paintFill.strokeWidth = 3;
    paintFill.strokeCap = StrokeCap.round;
    canvas.drawPath(path_1, paintFill);

    final path_2 = createAnimatedPath(pathes[2], animationPercent);
    paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = const Color(0xff4ADA63).withOpacity(1.0);
    canvas.drawPath(path_2, paintFill);

    final path_3 = createAnimatedPath(pathes[3], animationPercent);
    paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = const Color(0xff4ADA63).withOpacity(1.0);
    canvas.drawPath(path_3, paintFill);

    final path_4 = createAnimatedPath(pathes[4], animationPercent);
    paintFill = Paint()..style = PaintingStyle.stroke;
    paintFill.strokeCap = StrokeCap.round;
    paintFill.color = lightBorder;
    paintFill.strokeWidth = 2;

    canvas.drawPath(path_4, paintFill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({Key? key}) : super(key: key);
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: CustomPaint(
        painter: AnimatedPathPainter(_animation),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward(from: 0);
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

Path extractPathUntilLength(
  Path originalPath,
  double length,
) {
  var currentLength = 0.0;

  final path = Path();

  var metricsIterator = originalPath.computeMetrics().iterator;

  while (metricsIterator.moveNext()) {
    var metric = metricsIterator.current;

    var nextLength = currentLength + metric.length;

    final isLastSegment = nextLength > length;
    if (isLastSegment) {
      final remainingLength = length - currentLength;
      final pathSegment = metric.extractPath(0.0, remainingLength);

      path.addPath(pathSegment, Offset.zero);
      break;
    } else {
      // There might be a more efficient way of extracting an entire path
      final pathSegment = metric.extractPath(0.0, metric.length);
      path.addPath(pathSegment, Offset.zero);
    }

    currentLength = nextLength;
  }

  return path;
}

Path createAnimatedPath(
  Path originalPath,
  double animationPercent,
) {
  // ComputeMetrics can only be iterated once!
  final totalLength = originalPath
      .computeMetrics()
      .fold(0.0, (double prev, ui.PathMetric metric) => prev + metric.length);

  final currentLength = totalLength * animationPercent;

  return extractPathUntilLength(originalPath, currentLength);
}
