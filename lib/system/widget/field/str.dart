import 'package:flutter/material.dart';

/// 字符输入
class TextFieldStr extends StatefulWidget {
  String label;
  TextInputType? keyboardType = TextInputType.text;
  FormFieldValidator<String>? validator;

  TextFieldStr({super.key, required this.label, this.keyboardType, this.validator});

  @override
  State<StatefulWidget> createState() {
    return _TextFieldStrState();
  }
}

class _TextFieldStrState extends State<TextFieldStr> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _textController,
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      keyboardType: widget.keyboardType,
      validator: widget.validator,
    );
  }
}

