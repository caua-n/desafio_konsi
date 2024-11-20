import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final bool readOnly;
  final bool enabled;
  final bool autoFocus;
  final String? hintText;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;
  final bool obscureText;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    super.key,
    required this.labelText,
    required this.readOnly,
    this.autoFocus = false,
    this.enabled = true,
    this.hintText,
    this.keyboardType = TextInputType.text,
    required this.textEditingController,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      autofocus: autoFocus,
      decoration: InputDecoration(
        focusColor: Color(0xff7C7C7C),
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
