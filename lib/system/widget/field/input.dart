import 'package:flutter/material.dart';

/// 字符输入
class InputTextField extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextEditingController controller;

  const InputTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
