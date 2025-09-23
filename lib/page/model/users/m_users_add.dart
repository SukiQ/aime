import 'package:aime/cache/db/users.dart';
import 'package:aime/config/format.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/helper/string.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/system/widget/field/date.dart';
import 'package:aime/system/widget/field/input.dart';
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
  final _usernameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _birthdayController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nicknameController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);
    print('=============');

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
              _formKey.currentState!.save();
              _dao.add(_user);
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(key: _formKey, child: _buildUserTile(_items(l10n))),
          ),
        ],
      ),
    );
  }

  List<Widget> _items(AppLocalizations l10n) {
    final List<Widget> items = [
      InputTextField(
        label: l10n.username,
        controller: _usernameController,
        validator: (value) {
          if (StringHelper.isBlank(value)) {
            return l10n.usernameRequired;
          }
          if (!FormatConfig.usernameFormat.hasMatch(value!)) {
            return l10n.usernameErrorFormat;
          }
          return null;
        },
        onSaved: (value) => _user.username = value,
      ),
      InputTextField(
        label: l10n.nickname,
        controller: _nicknameController,
        validator: (value) {
          if (StringHelper.isBlank(value)) {
            return null;
          }
          if (!FormatConfig.usernameFormat.hasMatch(value!)) {
            return l10n.nicknameErrorFormat;
          }
          return null;
        },
        onSaved: (value) {
          if (value != null) {
            _user.nickname = value;
          }
        },
      ),
      TextFieldDate(
        label: l10n.birthday,
        controller: _birthdayController,
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
        onSaved: (value) {
          if (StringHelper.isNotBlank(value)) {
            _user.birthday = FormatConfig.dateFormat.parseStrict(value!);
          }
        },
      ),
    ];
    return items;
  }

  Widget _buildUserTile(List<Widget> items) {
    return ListView(
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: item,
        );
      }).toList(),
    );
  }

  Future<void> _load() async {
    _dao = await UsersDao.build(context);
  }
}
