import 'package:flutter/material.dart';
import 'package:nitenviro/utils/utils.dart';

class NESendButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  const NESendButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: <Color>[
            yellowSemiDarken,
            yellowDarken,
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: mainYellow,
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
          BoxShadow(
            color: mainYellow,
            offset: Offset(0.0, -1.5),
            blurRadius: 1.5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              title,
              style: textTheme.headline6!.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
