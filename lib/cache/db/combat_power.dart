import 'package:cbl/cbl.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';

import '../../system/domain/doc.dart';
import '../local/database.dart';

part 'combat_power.g.dart';

@JsonSerializable()
class CombatPower extends Doc {
  CombatPower({required this.username, required this.firepower});

  final String username;
  final int firepower;

  @override
  factory CombatPower.fromJson(Map<String, dynamic> json) =>
      _$CombatPowerFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CombatPowerToJson(this);

  @override
  String toString() {
    return 'CombatPower{username: $username, firepower: $firepower , id: $id}';
  }
}

class CombatPowerDao {
  late Database _database;
  late Collection _collection;

  CombatPowerDao(BuildContext context) {
    final locale = context.read<LocalDatabase>().locale;
    locale.then((database) async {
      _database = database;
      _collection = await _database.createCollection("m_combat_power");
      final index = FullTextIndexConfiguration(["username"]);
      await _collection.createIndex("overviewFTSIndex", index);
      final c = await _collection.indexes;
      for (var value in c) {
        print(value);
      }
    });
  }

  Future<List<CombatPower>> all() async {
    final c = await _collection.indexes;
    for (var value in c) {
      print(c);
    }
    final List<SelectResultInterface> distinct = [];
    distinct.add(SelectResult.expression(Meta.id).as('id'));
    distinct.add(SelectResult.expression(Expression.property("username")));
    distinct.add(SelectResult.expression(Expression.property("firepower")));

    final query = const QueryBuilder()
        .selectAllDistinct(distinct)
        .from(DataSource.collection(_collection));

    final resultSet = await query.execute();

    return await resultSet.asStream().map((result) {
      return CombatPower.fromJson(result.toPlainMap());
    }).toList();
  }

  /// 新增用户
  Future<void> add(CombatPower firepower) async {
    final doc = MutableDocument(firepower.toJson());
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

  void delete(String id) async {
    final doc = await _collection.document(id);
    if (doc == null) {
      return;
    }
    await _collection.deleteDocument(doc);
  }
}
