import 'package:aime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'm_combat_power.dart';

enum ModelEnum {
  combatPower(
    LucideIcons.sword300,
    CombatPowerPage(),
  );

  final IconData icon;
  final Widget widget;

  const ModelEnum(this.icon, this.widget);
}

extension ModelEnumExtension on ModelEnum {

  String getName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (this) {
      case ModelEnum.combatPower:
        return l10n.combatPower;
    }
  }
}