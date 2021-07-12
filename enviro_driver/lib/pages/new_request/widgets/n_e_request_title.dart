import 'package:flutter/material.dart';

class NERequestTitle extends StatelessWidget {
  final String imagePath;
  final String title;

  const NERequestTitle({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: 32,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: textTheme.headline6!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
