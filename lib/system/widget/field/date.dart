import 'package:aime/cache/local/language.dart';
import 'package:aime/setting/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

/// 日期选择器
class TextFieldDate extends StatelessWidget {
  String label;
  final TextEditingController controller;
  FormFieldValidator<String>? validator;
  FormFieldSetter<String>? onSaved;

  TextFieldDate({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleLanguage>(context).locale;

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: const Icon(LucideIcons.calendar300),
          onPressed: () => selectDate(context, locale),
        ),
      ),
      keyboardType: TextInputType.datetime,
      validator: validator,
      inputFormatters: [
        _DateTextFormatter(),
        LengthLimitingTextInputFormatter(10), // 限制 8 位数字
      ],
      onSaved: onSaved,
    );
  }

  /// 选择日期
  Future<void> selectDate(BuildContext context, Locale locale) async {
    DateTime initialDate;
    try {
      initialDate = FormatConfig.dateFormat.parse(controller.text);
    } catch (_) {
      initialDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      locale: locale,
    );

    if (picked != null) {
      controller.text = FormatConfig.dateFormat.format(picked);
    }
  }
}

class _DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var oldText = oldValue.text;
    var newText = newValue.text;
    if (oldText.length > newText.length) {
      if ((!oldText.endsWith('/')) && newText.endsWith('/')) {
        newText = newText.substring(0, newText.length - 1);
        return TextEditingValue(
          text: newText.toString(),
          selection: TextSelection.collapsed(offset: newText.length),
        );
      }
    }
    var text = newText.replaceAll(RegExp(r'[^0-9]'), ''); // 只保留数字
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      // 自动插入分隔符
      if ((text.length > 4 && i == 3) || (text.length > 6 && i == 5)) {
        buffer.write('/');
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
