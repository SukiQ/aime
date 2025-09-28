import 'package:aime/cache/local/database.dart';
import 'package:aime/setting/database.dart';
import 'package:aime/system/domain/doc.dart';
import 'package:cbl/cbl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullSearchDao {
  late final Database _database;

  FullSearchDao._(this._database);

  static Future<FullSearchDao> build(BuildContext context) async {
    return FullSearchDao._(await context.read<LocalDatabase>().locale);
  }

   Future<List<T>> search<T extends Doc>(
    String search,
    String tableName,
    String indexName,
    T Function(Map<String, Object?>) doc,
    List<String> params,
  ) async {
    final where = FullTextFunction.match(
      indexName: FullIndexes.users,
      query: "'*$search*'",
    );
    final List<SelectResultInterface> distinct = [];
    distinct.add(SelectResult.expression(Meta.id).as('id'));
    distinct.add(SelectResult.expression(Expression.property("username")));
    distinct.add(SelectResult.expression(Expression.property("nickname")));
    final query = const QueryBuilder()
        .selectAllDistinct(distinct)
        .from(
          DataSource.collection(await _database.createCollection("m_users")),
        )
        .where(where);
    final resultSet = await query.execute();
    return await resultSet.asStream().map((result) {
      return doc.call(result.toPlainMap());
    }).toList();
  }
}
