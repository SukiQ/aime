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
    super.initState();
    _dao = FirepowerDao();
    _dao.load(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:   [IconButton(
        icon: const Icon(Icons.language),
        onPressed: (){
          Future<List<String>>  c = _dao.getAll();
          c.then(
            (value) {
              print(value);
            }
          );
        },
      ),
        IconButton(
          icon: const Icon(Icons.abc),
          onPressed: (){
            _dao.add(Firepower(id: 1, name: '2222'));
          },
        ),
        IconButton(
          icon: const Icon(Icons.abc),
          onPressed: (){
            Future<List<String>>  c =  _dao.delete(Firepower(id: 1, name: '2222'));
            c.then(
                    (value) {
                  print(value);
                }
            );
          },
        ),
      ]
    );
  }

}

