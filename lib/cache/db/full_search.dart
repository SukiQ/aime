
import 'package:aime/cache/local/database.dart';
import 'package:cbl/cbl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FullSearchDao {
  late final Database _database;

  FullSearchDao._(this._database);

  static Future<FullSearchDao> build(BuildContext context) async {
    return FullSearchDao._(await context.read<LocalDatabase>().locale);
  }

  Future<List<Users>> search() async {
    final query = QueryBuilder()
        .select(SelectResult.expression(Meta.id),
        SelectResult.property("description"),
        SelectResult.expression(
            FullTextFunction.rank("descFTSIndex")).as("rank"))
        .from(DataSource.database(db))
        .where(
      FullTextFunction.match(
        FullTextIndexExpression.index("descFTSIndex"),
        "museum", // 搜索关键词
      ),
    )
        .orderBy(Ordering.expression(FullTextFunction.rank("descFTSIndex")).descending());
  }




}
