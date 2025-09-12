
import 'package:cbl/cbl.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../local/database.dart';

class Firepower {
  final int id;
  final String name;

  const Firepower({required this.id, required this.name});
}

class FirepowerDao {
  late Database _database;
  late Collection _collection;

  @override
  Future<void> load(BuildContext context) async {
    final locale = context.read<LocalDatabase>().locale;
    locale.then(
      (database) async {
        _database = database;
        _collection = await _database.createCollection('model', 'firepower');
      },
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
    final doc = MutableDocument({'id': 1, 'name': 'aaa'});

    await _collection.saveDocument(doc);
  }

  // Future<void> update(Firepower firepower) async {
  //   final query = const QueryBuilder()
  //       .select(SelectResult.all())
  //       .from(DataSource.collection(_collection))
  //       .where(Expression.property('id').equalTo(firepower.id));
  //
  //   final resultSet = await query.execute();
  //   final results = await resultSet
  //       .asStream()
  //       .map((result) => result.toJson())
  //       .toList();
  //   final doc = MutableDocument.withId()
  // }

  Future<List<String>> delete(Firepower firepower) async {
    final query = await  _database.createQuery(
        // 'SELECT META().id,* AS docId FROM aime'
      'SELECT META().id,* AS docId FROM aime'
    );
    final resultSet = await query.execute();
    return resultSet.asStream().map(
      (result) {
        return result.toJson();
      },
    ).toList();


    // final query = const QueryBuilder()
    //     .select(SelectResult.all())
    //     .from(DataSource.collection(_collection));
    //
    // final resultSet = await query.execute();
    // final results = await resultSet
    //     .asStream()
    //     .map((result) => result.keys)
    //     .toList();
    //
    print(query.sqlRepresentation);
    // _collection.deleteDocument();

  }
}
