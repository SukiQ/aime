import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/page/model/users/m_users_add.dart';
import 'package:aime/system/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class UsersUpdatePage extends StatefulWidget {
  const UsersUpdatePage({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() {
    return _UsersUpdatePageState();
  }
}

class _UsersUpdatePageState extends State<UsersUpdatePage> {
  bool _loading = true;
  final _formKey = GlobalKey<FormState>();
  late final UsersDetails _user;
  late final UsersDao _dao;
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

    return _loading
        ? LoadingWidget()
        : Scaffold(
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
                    _dao.update(_user);
                    Navigator.pop(context, _user);
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
    UsersDao.build(context)
        .then((dao) {
          _dao = dao;
          return _dao.details(widget.id);
        })
        .then((user) {
          setState(() {
            _user = user;
            _loading = false;
            _items = buildUserAddItems(context: context, user: _user);
          });
        });
  }
}
