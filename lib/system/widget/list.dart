import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../helper/screen.dart';

Widget buildLevel1ListTile(
  BuildContext context,
  IconData icon,
  String title,
  GestureTapCallback onTap,
) {
  final isWide = ScreenHelper.isWide(context);
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    trailing: isWide ? null : Icon(LucideIcons.chevronRight300),
    onTap: onTap,
  );
}

Widget buildLevel2ListTile(
  BuildContext context,
  IconData icon,
  String title,
  GestureTapCallback onTap,
) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    trailing: Icon(LucideIcons.chevronRight300),
    onTap: onTap,
  );
}
