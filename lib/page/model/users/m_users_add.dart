import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/helper/string.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/setting/format.dart';
import 'package:aime/system/widget/field/date.dart';
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
  late final List<Widget> _items;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    for (var item in _items) {
      if (item is ChangeNotifier) {
        (item as ChangeNotifier).dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);
    _items = buildUserAddItems(context: context, user: _user);

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
            child: Form(key: _formKey, child: _buildUserTile()),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTile() {
    return ListView(
      children: _items.map((item) {
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

List<Widget> buildUserAddItems({
  required BuildContext context,
  required Users user,
}) {
  final l10n = AppLocalizations.of(context)!;

  return [
    TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: TextEditingController(text: user.username),
      decoration: InputDecoration(labelText: l10n.username),
      validator: (value) {
        if (StringHelper.isBlank(value)) {
          return l10n.usernameRequired;
        }
        if (!FormatConfig.usernameFormat.hasMatch(value!)) {
          return l10n.usernameErrorFormat;
        }
        return null;
      },
      onSaved: (value) => user.username = value,
    ),
    TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: TextEditingController(text: user.nickname),
      decoration: InputDecoration(labelText: l10n.nickname),
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
        if (StringHelper.isNotBlank(value)) {
          user.nickname = value;
        }
      },
    ),
    TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      controller: TextEditingController(text: user.phone),
      decoration: InputDecoration(labelText: l10n.phone),
      validator: (value) {
        if (StringHelper.isBlank(value)) {
          return null;
        }
        if (!FormatConfig.phoneFormat.hasMatch(value!)) {
          return l10n.phoneErrorFormat;
        }
        return null;
      },
      onSaved: (value) {
        if (StringHelper.isNotBlank(value)) {
          user.phone = value;
        }
      },
    ),
    TextFieldDate(
      label: l10n.birthday,
      controller: TextEditingController(
        text: user.birthday == null
            ? null
            : FormatConfig.dateFormat.format(user.birthday!),
      ),
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
          user.birthday = FormatConfig.dateFormat.parseStrict(value!);
        }
      },
    ),
  ];
}
