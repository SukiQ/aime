import 'package:aime/cache/local/local_language.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

/// 日期选择器
class TextFieldDatePicker extends StatefulWidget {
  ValueChanged<DateTime>? onInput;

  TextFieldDatePicker({super.key, this.onInput});

  @override
  State<StatefulWidget> createState() {
    return _TextFieldDatePickerState();
  }
}

class _TextFieldDatePickerState extends State<TextFieldDatePicker> {
  final TextEditingController _dateController = TextEditingController();
  final DateFormat _formatter = DateFormat('yyyy/MM/dd');
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Provider.of<LocaleLanguage>(context).locale;


    return TextField(
      controller: _dateController,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.transparent,
        labelText: l10n.birthday,
        suffixIcon: IconButton(
          icon: const Icon(LucideIcons.calendar300),
          onPressed: () => selectDate(locale),
        ),
        errorText: _errorText,
      ),
      keyboardType: TextInputType.datetime,
      onSubmitted: (value) => _onInput(_dateController.text, l10n),
      onEditingComplete: () => _onInput(_dateController.text, l10n),
    );
  }

  /// 选择日期
  Future<void> selectDate(Locale locale) async {
    DateTime initialDate;
    try {
      initialDate = _formatter.parse(_dateController.text);
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
        _dateController.text = _formatter.format(picked);
      });
    }
  }

  /// 输入验证及赋值
  void _onInput(String value, AppLocalizations l10n) {
    try {
      final date = _formatter.parseStrict(value);
      _dateController.text = _formatter.format(date);
      widget.onInput?.call(date);
    } catch (_) {
      setState(() {
        _errorText = l10n.errorDateFormat;
      });
    }
  }
}

