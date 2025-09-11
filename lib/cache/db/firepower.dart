
import 'package:aime/cache/local/database.dart';
import 'package:cbl/cbl.dart';
import 'package:cbl_flutter/cbl_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class Firepower {
  final int id;
  final String name;

  const Firepower({required this.id, required this.name});
}


class FirepowerDao {
  late Collection _collection;

  @override
  Future<void> load(BuildContext context)  async {
   Database.openAsync('aime').then(
      (database) async =>  {
        _collection = await database.createCollection('model', 'firepower')
      }
      );
  }


  Future<List<String>> getAll() async {
    final query = const QueryBuilder()
        .select(SelectResult.all())
        .from(DataSource.collection(_collection));

    final resultSet = await query.execute();
    final results = await resultSet
        .asStream()
        .map((result) => result.toJson())
        .toList();
    return results;
  }

  /// 新增用户
  Future<void> add(Firepower firepower) async {
    final doc = MutableDocument({
      'id': 1,
      'name': 'aaa',
    });

    await _collection.saveDocument(doc);
  }
}
