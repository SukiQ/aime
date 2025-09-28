import 'package:aime/cache/db/full_search.dart';
import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/helper/string.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/page/model/users/m_users_detail.dart';
import 'package:aime/setting/app_routes.dart';
import 'package:aime/setting/database.dart';
import 'package:aime/system/widget/divider.dart';
import 'package:aime/system/widget/field/search.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}


class _SearchPageState extends State<SearchPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _queryController = TextEditingController();
  late FullSearchDao _dao;
  List<Users> _search = [];

  @override
  void initState() {
    super.initState();
    _queryController.addListener(() {
      _getSearch();
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


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final _ = ScreenHelper.isWide(context);
    // 查询

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
                  return const ListTileDivider();
                },
                controller: _scrollController,
                  itemCount: _search.length,
                  itemBuilder: (context, index) {
                    return _buildUserTile(index, _search[index]);
                  }
                  )
            )
          ),
        ],
      ),
    );

  }

  Future<void> _load() async {
    FullSearchDao.build(context)
        .then((dao) {
      _dao = dao;
    });
  }


Widget _buildUserTile(int index, Users users) {
  return ListTile(
      leading: Icon(LucideIcons.userRound300),
      title: Text(
        StringHelper.isBlank(users.nickname)
            ? users.username!
            : users.nickname!,
      ),
      subtitle: StringHelper.isNotBlank(users.nickname)
          ? Text(users.username!)
          : null,
      visualDensity: VisualDensity(
        vertical: StringHelper.isNotBlank(users.nickname) ? -2 : 2,
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
    );
}

  void _onNavigate(Object? result) {
    // if (result == null) {
    //   return;
    // }
    // final navigatorResult = result as NavigatorResult;
    // switch (navigatorResult.operation) {
    //   case NavigatorOperation.none:
    //     return;
    //   case NavigatorOperation.remove:
    //     setState(() {
    //       final user = navigatorResult.result as Users;
    //       _users.removeWhere((element) => element.id == user.id);
    //     });
    //     return;
    //   case NavigatorOperation.update:
    //     setState(() {
    //       final user = navigatorResult.result as Users;
    //       _users[_users.indexWhere((element) => element.id == user.id)] = user;
    //     });
    //     return;
    //   case NavigatorOperation.add:
    //     final user = navigatorResult.result as Users;
    //     _users.add(user);
    //     return;
    // }
  }

  Future<void> _getSearch() async {
     _dao.search<Users>(
      _queryController.text,
      Tables.users,
      FullIndexes.users,
          (map) => Users.fromJson(map),
      ["username", "nickname"],
    ).then(
       (value) {
         setState(() {
           _search = value;
         });
       },
     );
  }
}
