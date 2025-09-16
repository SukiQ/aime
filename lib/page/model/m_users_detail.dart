import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class UsersDetailPage extends StatelessWidget {
  final Users users;

  const UsersDetailPage({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          _buildUserDetailTile(
            LucideIcons.cake300,
            l10n.birthday,
            users.birthday?.timeZoneName,
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetailTile(IconData icon, String title, String? subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
    );
  }
}
