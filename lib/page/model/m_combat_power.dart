import 'package:aime/cache/db/combat_power.dart';
import 'package:flutter/material.dart';

import '../../helper/screen.dart';
import '../../l10n/app_localizations.dart';

class CombatPowerPage extends StatefulWidget {
  const CombatPowerPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CombatPowerPageState();
  }
}

class _CombatPowerPageState extends State<CombatPowerPage> {
  late CombatPowerDao _dao;

  @override
  void initState() {
    super.initState();
    _dao = CombatPowerDao(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      appBar: isWide ? null : AppBar(title: Text(l10n.combatPower)),
      body: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              Future<List<CombatPower>> c = _dao.all();
              c.then((value) {
                for (var value1 in value) {
                  print(value1);
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.abc),
            onPressed: () {
              _dao.add(CombatPower(username: '花小琪', firepower: 10));
            },
          ),
          IconButton(
            icon: const Icon(Icons.abc),
            onPressed: () {
              _dao.delete("-3L608APCeclAurVkLBJC4Y");
            },
          ),
        ],
      ),
    );
  }
}
