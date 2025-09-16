import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/page/model/m_users.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'm_combat_power.dart';

enum ModelEnum {
  combatPower(
    LucideIcons.sword300,
    CombatPowerPage(),
  ),
  users(
    LucideIcons.users300,
    UsersPage(),
  );

  final IconData icon;
  final Widget widget;

  const ModelEnum(this.icon, this.widget);
}

extension ModelEnumExtension on ModelEnum {

  String name(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (this) {
      case ModelEnum.combatPower:
        return l10n.combatPower;
        break;
      case ModelEnum.users:
        return l10n.users;
        break;
    }
  }
}