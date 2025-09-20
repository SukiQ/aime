import 'package:aime/cache/db/users.dart';
import 'package:aime/config/format.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/helper/string.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/system/widget/field/date.dart';
import 'package:aime/system/widget/field/str.dart';
import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);
    final List<Widget> items = [
      TextFieldStr(
        label: l10n.username,
        validator: (value) =>
        StringHelper.isBlank(value)
            ? l10n.usernameRequired
            : null,
      ),
      TextFieldDate(
        label: l10n.birthday,
        validator: (value) {
          if (StringHelper.isBlank(value)) {
            return null;
          }
          try {
            FormatConfig.dateFormat.parseStrict(value!);
          } catch (e) {
            return l10n.errorDateFormat;
          }
          return null;
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addUser),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.check300),
            tooltip: l10n.modelAddLabel,
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              print('===$_user');
              // _dao.add(_user);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: _buildUserTile(items),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildUserTile(List<Widget> items) {
    return ListView(
      children: items.map(
        (item) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: item,
          );
        },
      ).toList(),
    );
  }

  Future<void> _load() async {
    _dao = await UsersDao.build(context);
  }

}

