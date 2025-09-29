import 'package:aime/cache/db/full_search.dart';
import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/helper/string.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/page/model/users/m_users_detail.dart';
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
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _load() async {
    FullSearchDao.build(context).then((dao) {
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
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UsersDetailPage(id: users.id!),
          ),
        );
      },
    );
  }


  Future<void> _getSearch() async {
    _dao
        .search<Users>(
          _queryController.text,
          Tables.users,
          FullIndexes.users,
          (map) => Users.fromJson(map),
          ["username", "nickname"],
        )
        .then((value) {
          setState(() {
            _search = value;
          });
        });
  }
}
