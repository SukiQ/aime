import 'dart:ffi';

import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/page/model/users/m_users_add.dart';
import 'package:aime/page/model/users/m_users_detail.dart';
import 'package:aime/system/widget/field/search.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UsersPageState();
  }
}

class _UsersPageState extends State<UsersPage> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _queryController = TextEditingController();
  late UsersDao _dao;
  List<Users> _users = [];

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
      appBar: AppBar(
        title: Text(l10n.users),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.userRoundPlus400),
            tooltip: l10n.modelAddLabel,
            onPressed: () async {
              bool? result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UsersAddPage()),
              );
              if (result != null && result) {
                _load();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SearchTextField(controller: _queryController),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: _users.length, // 多加 1 用于底部加载动画
              itemBuilder: (context, index) {
                return _buildUserTile(index, _users[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _load() async {
    UsersDao.build(context)
        .then((dao) {
          _dao = dao;
          return _dao.all();
        })
        .then((user) {
          setState(() {
            _users = user;
          });
        });
  }

  Widget _buildUserTile(int index, Users users) {
    return Dismissible(
      key: Key(users.id!),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        _dao.delete(users.id!);
        setState(() {
          _users.removeAt(index);
        });
      },
      child: ListTile(
        leading: Icon(LucideIcons.user300),
        title: Text(users.nickname ?? users.username!),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UsersDetailPage(users.id!)),
          );
        },
      ),
    );
  }
}
