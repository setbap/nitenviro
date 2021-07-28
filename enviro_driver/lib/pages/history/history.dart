import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enviro_driver/shared_widget/shared_widget.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundCirclePainter(
      circlesPainter: (size) => [
        CirclePaintInfo(
            radius: 20,
            center: Offset(size.width / 8, size.height / 8),
            isRightPrimary: false),
        CirclePaintInfo(
          radius: 15,
          center: Offset(size.width / 2, size.height / 4),
        ),
        CirclePaintInfo(
          radius: 20,
          center: Offset(size.width - 20, size.height / 4),
          isRightPrimary: false,
        ),
        CirclePaintInfo(
          radius: 35,
          center: Offset(size.width / 2, 0),
          isRightPrimary: false,
        ),
        CirclePaintInfo(
          radius: 30,
          center: Offset(size.width - 90, size.height),
          isRightPrimary: false,
        ),
        CirclePaintInfo(
          radius: 30,
          center: Offset(90, size.height),
          isRightPrimary: false,
        ),
      ],
      child: const CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [],
      ),
    );
  }
}
