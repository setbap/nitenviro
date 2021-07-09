import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/pages/recycle_finder/widgets/widgets.dart';

class CustomChip extends StatelessWidget {
  final String item;

  const CustomChip({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: CustomChipBase(
        title: mapRecyclable[item] ?? "",
        backgroundColor: recyclableColor(item, 0.1),
        borderColor: recyclableColor(item, 0.5),
      ),
    );
  }
}

class CustomChipBase extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color borderColor;

  const CustomChipBase({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      visualDensity: VisualDensity.compact,
      label: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      padding: const EdgeInsets.all(0),
      backgroundColor: backgroundColor,
      labelPadding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 12,
      ),
      side: BorderSide(
        color: borderColor,
        width: 1,
      ),
    );
  }
}
