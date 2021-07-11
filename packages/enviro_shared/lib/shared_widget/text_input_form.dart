import 'package:enviro_shared/enviro_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NEFormTextInput extends StatelessWidget {
  final TextEditingController? textEditingController;
  final List<TextInputFormatter> textInputFormatter;
  final FormFieldValidator<String> validator;
  final String label;
  final String hint;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool isReadOnly;
  final bool showClearButton;
  final IconData? iconData;

  const NEFormTextInput({
    Key? key,
    this.textEditingController,
    this.iconData,
    required this.textInputFormatter,
    required this.validator,
    required this.label,
    required this.hint,
    this.inputType = TextInputType.text,
    this.isReadOnly = false,
    this.showClearButton = true,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          TextFormField(
            controller: textEditingController,
            inputFormatters: textInputFormatter,
            autocorrect: false,
            readOnly: isReadOnly,
            keyboardType: inputType,
            maxLines: maxLines,
            textInputAction: textInputAction,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            onFieldSubmitted: (value) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.focusedChild?.nextFocus();
              }
            },
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              prefixIcon: iconData == null ? null : Icon(iconData),
              filled: true,
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
              hintStyle: const TextStyle(color: Colors.grey),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: mainYellow),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              errorMaxLines: 1,
            ),
          ),
          if (showClearButton)
            Positioned(
              left: -8,
              top: -8,
              child: SizedBox(
                width: 48,
                height: 48,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(24),
                    ),
                    child:
                        const Icon(Icons.clear, color: Colors.grey, size: 16),
                    onTap: () => textEditingController?.clear(),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
