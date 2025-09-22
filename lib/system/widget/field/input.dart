import 'package:flutter/material.dart';

/// 字符输入
class InputTextField extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextEditingController _textController = TextEditingController();

  InputTextField({
    super.key,
    required this.label,
    this.keyboardType,
    this.validator,
    this.onSaved,
  });

  // @override
  // State<StatefulWidget> createState() {
  //   return _InputTextFieldState();
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: _textController,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
