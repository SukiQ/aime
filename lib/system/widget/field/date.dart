import 'package:aime/cache/local/local_language.dart';
import 'package:aime/config/format.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

/// 日期选择器
class TextFieldDate extends StatefulWidget {
  String label;
  FormFieldValidator<String>? validator;

  TextFieldDate({super.key, required this.label, this.validator});

  @override
  State<StatefulWidget> createState() {
    return _TextFieldDateState();
  }
}

class _TextFieldDateState extends State<TextFieldDate> {
  final TextEditingController _textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleLanguage>(context).locale;

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: _textController,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: IconButton(
          icon: const Icon(LucideIcons.calendar300),
          onPressed: () => selectDate(locale),
        ),
      ),
      keyboardType: TextInputType.datetime,
      validator: widget.validator,
    );
  }

  /// 选择日期
  Future<void> selectDate(Locale locale) async {
    DateTime initialDate;
    try {
      initialDate = FormatConfig.dateFormat.parse(_textController.text);
    } catch (_) {
      initialDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: locale,
    );

    if (picked != null) {
      setState(() {
        _textController.text = FormatConfig.dateFormat.format(picked);
      });
    }
  }
}

