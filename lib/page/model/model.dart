import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:cbl/cbl.dart';
import 'package:cbl_flutter/cbl_flutter.dart';

import 'package:aime/config/style_config.dart';

import '../../cache/db/combat_power.dart';

class ModelPage extends StatefulWidget {
  const ModelPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ModelPageState();
  }
}

class _ModelPageState extends State<ModelPage> {
  late CombatPowerDao _dao;

  @override
  void initState() {
    super.initState();
    _dao = CombatPowerDao(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            _dao.delete("--2eUo7RWsASZR3kLJ7e6en");
          },
        ),
      ],
    );
  }
}
