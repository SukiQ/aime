import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../helper/screen_helper.dart';

Widget buildListTile(
    BuildContext context,
    IconData icon,
    String title,
    GestureTapCallback onTap
    ) {
  final isWide = ScreenHelper.isWide(context);
  return Padding(padding: isWide ? EdgeInsets.only(left: 10) : EdgeInsets.zero,child: ListTile(
    leading: Icon(icon),
    title: Text(title),
    trailing: isWide ? null : Icon(LucideIcons.chevronRight300),
    onTap: onTap,
  ),);
}
