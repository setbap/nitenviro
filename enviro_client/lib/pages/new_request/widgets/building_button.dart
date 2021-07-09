import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class NEBuildingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Tuple2<Color, Color> colors;
  final bool isActive;
  final String title;

  const NEBuildingButton({
    Key? key,
    required this.onPressed,
    required this.colors,
    required this.isActive,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 3,
            color: isActive ? colors.item1 : Colors.transparent,
          ),
        ),
        margin: const EdgeInsets.only(
          left: 4,
          right: 0,
          bottom: 8,
          top: 8,
        ),
        padding: const EdgeInsets.all(1),
        child: Container(
          height: 80,
          width: 96,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [colors.item1, colors.item2],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
