import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/page/model/risk/m_risk.dart';
import 'package:aime/page/model/task/m_tasks.dart';
import 'package:aime/page/model/users/m_users.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/clarity.dart';
import 'package:iconify_flutter/icons/el.dart';
import 'package:iconify_flutter/icons/mingcute.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'm_combat_power.dart';

enum ModelEnum {
  users(LucideIcons.users300 , UsersPage()),
  clothes(LucideIcons.shirt300, UsersPage()),
  risk(LucideIcons.batteryWarning300, RiskPage()),
  search(LucideIcons.search300, UsersPage()),
  tasks(LucideIcons.file300, TasksPage());

  final IconData icon;
  final Widget widget;

  const ModelEnum(this.icon, this.widget);
}

extension ModelEnumExtension on ModelEnum {
  String name(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (this) {
      case ModelEnum.risk:
        return l10n.risk;
      case ModelEnum.users:
        return l10n.profiling;
      case ModelEnum.clothes:
        return l10n.users;
      case ModelEnum.search:
        return l10n.search;
      case ModelEnum.tasks:
        return l10n.task;
    }
  }
}
