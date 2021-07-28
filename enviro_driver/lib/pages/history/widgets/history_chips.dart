import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/material.dart';

class HistoryChips extends StatelessWidget {
  const HistoryChips(
      {Key? key,
      required this.isSelected,
      required this.text,
      required this.onTap})
      : super(key: key);

  final bool isSelected;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(
            text,
            style: isSelected
                ? Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.bold)
                : Theme.of(context).textTheme.subtitle1,
          ),
          backgroundColor: isSelected ? veryLightYellow : lightYellow,
          avatar: isSelected
              ? const Icon(
                  Icons.done,
                  color: darkGreen,
                )
              : null,
          side:
              isSelected ? const BorderSide(color: darkGreen, width: 3) : null,
        ),
      ),
    );
  }
}
