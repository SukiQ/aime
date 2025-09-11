import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:cbl/cbl.dart';
import 'package:cbl_flutter/cbl_flutter.dart';

import 'package:aime/config/style_config.dart';

import '../../cache/db/firepower.dart';

class ModelPage extends StatefulWidget {
  const ModelPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ModelPageState();
  }
}

class _ModelPageState extends State<ModelPage>{
  late FirepowerDao _dao;

  @override
  void initState() {
    _dao = FirepowerDao();
    _dao.load(context);
  }

  @override
  Widget build(BuildContext context) {
    // _dao.add(Firepower(id: 1, name: 'aaa'));
    _dao.getAll().then((value) {
      print(value);
    });
    return const Center(child: Text("模型", style: TextStyle(fontSize: 24)));
  }

}

