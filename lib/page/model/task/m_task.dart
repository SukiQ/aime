import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/helper/string.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/page/model/users/m_users_detail.dart';
import 'package:aime/setting/app_routes.dart';
import 'package:aime/system/domain/navigator.dart';
import 'package:aime/system/widget/divider.dart';
import 'package:aime/system/widget/field/search.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TaskPageState();
  }
}


class _TaskPageState extends State<TaskPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _queryController = TextEditingController();
  late UsersDao _dao;
  List<Users> _users = [];
  List<Users> _search = [];
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _queryController.addListener(() {
      setState(() {});
    });
    _load();
    // _controller.addListener(() {
    //   var nextPageTrigger = 0.8 * _controller.position.maxScrollExtent;
    //   if (_controller.position.pixels > nextPageTrigger) {
    //     _loadMore();
    //   }
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;
    setState(() => _isLoadingMore = true);
    _dao.page(_users.length).then((users) {
      if (users.isNotEmpty) {
        setState(() {
          _users.addAll(users);
          _isLoadingMore = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final _ = ScreenHelper.isWide(context);
    _search = _users
        .where(
          (user) =>
              user.username!.toLowerCase().contains(
                _queryController.text.toLowerCase(),
              ) ||
              (StringHelper.isBlank(user.nickname)
                  ? false
                  : user.nickname!.toLowerCase().contains(
                      _queryController.text.toLowerCase(),
                    )),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.users),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.userRoundPlus400),
            tooltip: l10n.modelAddLabel,
            onPressed: () async {
              _onNavigate(
                await Navigator.pushNamed(context, AppRoutes.mUsersAdd),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SearchTextField(controller: _queryController),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    indent: 7,
                    endIndent: 7,
                    color: Theme.of(context).colorScheme.scrim,
                    thickness: 0.5,
                    height: 1,
                  );
                },

                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                itemCount: _search.length,
                itemBuilder: (context, index) {
                  return buildUserTile(index, _search[index]);
                },
              ),
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

  Widget buildUserTile(int index, Users users) {
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
        minTileHeight: 60,
        leading: Icon(LucideIcons.userRound300),
        title: Text(
          StringHelper.isBlank(users.nickname)
              ? users.username!
              : users.nickname!,
        ),
        onTap: () async {
          _onNavigate(
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UsersDetailPage(id: users.id!),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onNavigate(Object? result) {
    if (result == null) {
      return;
    }
    final navigatorResult = result as NavigatorResult;
    switch (navigatorResult.operation) {
      case NavigatorOperation.none:
        return;
      case NavigatorOperation.remove:
        setState(() {
          final user = navigatorResult.result as Users;
          _users.removeWhere((element) => element.id == user.id);
        });
        return;
      case NavigatorOperation.update:
        setState(() {
          final user = navigatorResult.result as Users;
          _users[_users.indexWhere((element) => element.id == user.id)] = user;
        });
        return;
      case NavigatorOperation.add:
        final user = navigatorResult.result as Users;
        _users.add(user);
        return;
    }
  }
}
