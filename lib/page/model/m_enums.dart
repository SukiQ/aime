import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/page/model/risk/m_risk.dart';
import 'package:aime/page/model/users/m_users.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'm_combat_power.dart';

enum ModelEnum {
  combatPower(LucideIcons.sword200, CombatPowerPage(), Color(0xFFF1FFF0)),
  users(LucideIcons.contactRound200, UsersPage(), Color(0xFFFFF0F0)),
  clothes(LucideIcons.shirt200, UsersPage(), Color(0xFFF0F3FF)),
  risk(LucideIcons.octagonAlert200, RiskPage(), Color(0xFFFFFBF0)),
  search(LucideIcons.search200, UsersPage(), Color(0xFFF0F0FF));

  final IconData icon;
  final Widget widget;
  final Color color;

  const ModelEnum(this.icon, this.widget, this.color);
}

extension ModelEnumExtension on ModelEnum {
  String name(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (this) {
      case ModelEnum.combatPower:
        return l10n.combatPower;
      case ModelEnum.risk:
        return l10n.risk;
      case ModelEnum.users:
        return l10n.users;
      case ModelEnum.clothes:
        return l10n.users;
      case ModelEnum.search:
        return l10n.search;
    }
  }
}
