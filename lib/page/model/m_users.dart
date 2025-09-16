import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
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
  late UsersDao _dao;
  String _query = "";

  @override
  void initState() {
    super.initState();
    _dao = UsersDao(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      appBar: isWide
          ? null
          : AppBar(
              title: Text(l10n.users),
              actions: [
                IconButton(
                  icon: const Icon(LucideIcons.plus400),
                  tooltip: l10n.modelAddLabel,
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text("点击了添加")));
                  },
                ),
                IconButton(
                  icon: const Icon(LucideIcons.minus400),
                  tooltip: l10n.modelRemoveLabel,
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text("点击了删除")));
                  },
                ),
              ],
            ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.search,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() => _query = "");
                  },
                )
                    : null,
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          Expanded(
            child: ListView(
              children: Languages.values
                  .where(
                    (lang) =>
                lang.label.toLowerCase().contains(
                  _query.toLowerCase(),
                ) ||
                    lang
                        .getDisplayName(context)
                        .toLowerCase()
                        .contains(_query.toLowerCase()),
              )
                  .map((lang) {
                return _buildLanguageTile(
                  lang,
                  context,
                  isWide,
                  colorScheme,
                  localeProvider,
                );
              })
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
