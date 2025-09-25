import 'package:cbl/cbl.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';

import '../../system/domain/doc.dart';
import '../local/database.dart';

part 'users.g.dart';

@JsonSerializable()
class Users extends Doc {
  Users({this.username, this.nickname, this.phone, this.birthday});

  String? username;
  String? nickname;
  String? phone;
  DateTime? birthday;

  @override
  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UsersToJson(this);

  @override
  String toString() {
    return 'Users{$username, nickname: $nickname, phone: $phone, birthday: $birthday, id: $id}';
  }
}

class UsersDao {
  late final Collection _collection;

  UsersDao._(this._collection);

  static Future<UsersDao> build(BuildContext context) async {
    final database = await context.read<LocalDatabase>().locale;
    return UsersDao._(await database.createCollection("m_users"));
  }

  Future<List<Users>> all() async {
    final List<SelectResultInterface> distinct = [];
    distinct.add(SelectResult.expression(Meta.id).as('id'));
    distinct.add(SelectResult.expression(Expression.property("username")));
    distinct.add(SelectResult.expression(Expression.property("nickname")));

    final query = const QueryBuilder()
        .selectAllDistinct(distinct)
        .from(DataSource.collection(_collection));

    final resultSet = await query.execute();

    return await resultSet.asStream().map((result) {
      return Users.fromJson(result.toPlainMap());
    }).toList();
  }

  Future<List<Users>> page(int offset) async {
    final List<SelectResultInterface> distinct = [];
    distinct.add(SelectResult.expression(Meta.id).as('id'));
    distinct.add(SelectResult.expression(Expression.property("username")));
    distinct.add(SelectResult.expression(Expression.property("nickname")));

    final query = const QueryBuilder()
        .selectAllDistinct(distinct)
        .from(DataSource.collection(_collection))
        .limit(Expression.integer(12), offset: Expression.integer(offset));

    final resultSet = await query.execute();

    return await resultSet.asStream().map((result) {
      return Users.fromJson(result.toPlainMap());
    }).toList();
  }

  Future<Users> details(String id) async {
    final List<SelectResultInterface> distinct = [];
    distinct.add(SelectResult.expression(Meta.id).as('id'));
    distinct.add(SelectResult.expression(Expression.property("username")));
    distinct.add(SelectResult.expression(Expression.property("nickname")));
    distinct.add(SelectResult.expression(Expression.property("phone")));
    distinct.add(SelectResult.expression(Expression.property("birthday")));

    final query = const QueryBuilder()
        .selectAllDistinct(distinct)
        .from(DataSource.collection(_collection))
        .where(Expression.property('id').equalTo(Expression.string(id)));

    final resultSet = await query.execute();

    return await resultSet.asStream().map((result) {
      return Users.fromJson(result.toPlainMap());
    }).first;
  }

  Future<void> add(Users users) async {
    final doc = MutableDocument(users.toJson());
    print(users.toJson());
    await _collection.saveDocument(doc);
  }

  Future<void> update(Users users) async {
    final doc = await _collection.document(users.id!);
    final mutableDoc = doc!.toMutable();
    users.toJson().forEach((key, value) {
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
