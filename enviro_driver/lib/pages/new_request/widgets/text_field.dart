import 'package:flutter/material.dart';
import 'package:enviro_driver/utils/utils.dart';

class NETextField extends StatelessWidget {
  final String hint;
  final String? error;
  final TextEditingController textEditingController;

  const NETextField({
    Key? key,
    required this.hint,
    this.error,
    required this.textEditingController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        errorText: error,
        fillColor: lightBorder,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: darkBorder),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        focusColor: lightYellow,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: mainYellow),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
