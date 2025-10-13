import 'package:aime/setting/database.dart';
import 'package:cbl/cbl.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';

import '../../system/domain/doc.dart';
import '../local/database.dart';

part 'task.g.dart';

@JsonSerializable()
class TaskDetails extends Task {
  TaskDetails({this.createTime});

  DateTime? createTime;

  @override
  factory TaskDetails.fromJson(Map<String, dynamic> json) =>
      _$TaskDetailsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TaskDetailsToJson(this);

  @override
  String toString() {
    return 'Task{$name, progress: $progress, createTime: $createTime';
  }
}

@JsonSerializable()
class Task extends Doc {
  Task({this.name, this.progress});

  String? name;
  double? progress;


  @override
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

class TaskDao {
  late final Collection _collection;

  TaskDao._(this._collection);

  static Future<TaskDao> build(BuildContext context) async {
    final database = await context.read<LocalDatabase>().locale;
    final collection = await database.createCollection(Tables.task);
    final index = IndexBuilder.fullTextIndex([FullTextIndexItem.property("name"), FullTextIndexItem.property("progress")]).ignoreAccents(false);
    collection.createIndex(FullIndexes.task, index);
    return TaskDao._(collection);
  }

  Future<List<Task>> all() async {
    final List<SelectResultInterface> distinct = [];
    distinct.add(SelectResult.expression(Meta.id).as('id'));
    distinct.add(SelectResult.expression(Expression.property("name")));
    distinct.add(SelectResult.expression(Expression.property("progress")));

    final query = const QueryBuilder()
        .selectAllDistinct(distinct)
        .from(DataSource.collection(_collection));

    final resultSet = await query.execute();

    return await resultSet.asStream().map((result) {
      return Task.fromJson(result.toPlainMap());
    }).toList();
  }

  Future<List<Task>> page(int offset) async {
    final List<SelectResultInterface> distinct = [];
    distinct.add(SelectResult.expression(Meta.id).as('id'));
    distinct.add(SelectResult.expression(Expression.property("name")));
    distinct.add(SelectResult.expression(Expression.property("createTime")));

    final query = const QueryBuilder()
        .selectAllDistinct(distinct)
        .from(DataSource.collection(_collection))
        .limit(Expression.integer(12), offset: Expression.integer(offset));

    final resultSet = await query.execute();

    return await resultSet.asStream().map((result) {
      return Task.fromJson(result.toPlainMap());
    }).toList();
  }

  Future<TaskDetails> details(String id) async {
    final List<SelectResultInterface> distinct = [];
    distinct.add(SelectResult.expression(Meta.id).as('id'));
    distinct.add(SelectResult.expression(Expression.property("name")));
    distinct.add(SelectResult.expression(Expression.property("progress")));
    distinct.add(SelectResult.expression(Expression.property("createTime")));

    final query = const QueryBuilder()
        .selectAllDistinct(distinct)
        .from(DataSource.collection(_collection))
        .where(Expression.property('id').equalTo(Expression.string(id)));

    final resultSet = await query.execute();

    return await resultSet.asStream().map((result) {
      return TaskDetails.fromJson(result.toPlainMap());
    }).first;
  }

  Future<bool> add(TaskDetails task) async {
    final doc = MutableDocument(task.toJson());
    task.id = doc.id;
    return await _collection.saveDocument(doc);
  }

  Future<void> update(TaskDetails task) async {
    final doc = await _collection.document(task.id!);
    final mutableDoc = doc!.toMutable();
    task.toJson().forEach((key, value) {
      if (value == null) {
        return;
      }
      mutableDoc.setValue(value, key: key);
    });
    await _collection.saveDocument(mutableDoc);
  }

  void delete(String id) async {
    final doc = await _collection.document(id);
    if (doc == null) {
      return;
    }
    await _collection.deleteDocument(doc);
  }
}
