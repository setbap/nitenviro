import 'package:flutter/material.dart';
import 'package:enviro_shared/utils/utils.dart';

class NESendButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final bool? loading;
  const NESendButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.loading = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: loading!
              ? <Color>[
                  yellowSemiDarken.withOpacity(0.2),
                  yellowDarken.withOpacity(0.2),
                ]
              : <Color>[
                  yellowSemiDarken,
                  yellowDarken,
                ],
        ),
        boxShadow: loading!
            ? []
            : const [
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
          onTap: loading! ? null : onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 40,
              ),
              Text(
                title,
                style: textTheme.headline6!
                    .copyWith(color: loading! ? Colors.grey : Colors.white),
              ),
              AnimatedOpacity(
                opacity: loading! ? 1 : 0,
                duration: const Duration(milliseconds: 400),
                child: Transform.scale(
                  scale: 0.75,
                  child: const CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
