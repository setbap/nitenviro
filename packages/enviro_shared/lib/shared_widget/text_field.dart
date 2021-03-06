import 'package:enviro_shared/enviro_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NETextField extends StatelessWidget {
  final String hint;
  final String? error;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const NETextField({
    Key? key,
    required this.hint,
    this.error,
    required this.textEditingController,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      autofocus: false,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
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
