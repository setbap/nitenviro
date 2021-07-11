import 'package:flutter/material.dart';
import 'package:enviro_shared/utils/utils.dart';

class BTNWithLoading extends StatelessWidget {
  const BTNWithLoading({
    Key? key,
    required this.title,
    required this.loadingTitle,
    required this.isLoading,
    required this.onSubmit,
  }) : super(key: key);
  final String title;
  final String loadingTitle;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onSubmit,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        primary: darkGreen,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                isLoading ? loadingTitle : title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: isLoading
                ? Transform.scale(
                    scale: 0.75,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
