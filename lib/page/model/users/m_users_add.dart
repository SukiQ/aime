import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/helper/string.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/system/widget/field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class UsersAddPage extends StatefulWidget {
  const UsersAddPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UsersAddPageState();
  }
}

class _UsersAddPageState extends State<UsersAddPage> {
  late UsersDao _dao;
  final Users _user = Users();
  final TextEditingController _dateController = TextEditingController();
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      appBar: isWide
          ? null
          : AppBar(
              title: Text(l10n.addUser),
              actions: [
                IconButton(
                  icon: const Icon(LucideIcons.check300),
                  tooltip: l10n.modelAddLabel,
                  onPressed: () {
                    if (StringHelper.isNotBlank(_user.username)) {
                      _dao.add(_user);
                    }
                    ;
                  },
                ),
              ],
            ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                      labelText: l10n.username,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _user.username = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextFieldDatePicker(
                    onInput: (value) {
                      setState(() {
                        _user.birthday = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _validateInput(String value) {
    try {
      final date = _formatter.parseStrict(value);
      _dateController.text = _formatter.format(date);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("请输入正确的日期格式：yyyy-MM-dd")),
      );
    }
  }

  Future<void> _load() async {
    _dao = await UsersDao.build(context);
  }
}
