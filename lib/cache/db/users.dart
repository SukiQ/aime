import 'package:cbl/cbl.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';

import '../../system/domain/doc.dart';
import '../local/database.dart';

part 'users.g.dart';

@JsonSerializable()
class Users extends Doc {
  Users(this.username, {this.phone,this.birthday});

  final String username;
  final String? phone;
  final DateTime? birthday;

  @override
  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UsersToJson(this);

  @override
  String toString() {
    return 'Users{$username, phone: $phone, birthday: $birthday, id: $id}';
  }
}

class UsersDao {
  late Database _database;
  late Collection _collection;

  UsersDao(BuildContext context) {
    final locale = context.read<LocalDatabase>().locale;
    locale.then((database) async {
      _database = database;
      _collection = await _database.createCollection("m_users");
    });
  }

  Future<List<Users>> all() async {
    final List<SelectResultInterface> distinct = [];
    distinct.add(SelectResult.expression(Meta.id).as('id'));
    distinct.add(SelectResult.expression(Expression.property("username")));
    distinct.add(SelectResult.expression(Expression.property("phone")));
    distinct.add(SelectResult.expression(Expression.property("birthday")));

    final query = const QueryBuilder()
        .selectAllDistinct(distinct)
        .from(DataSource.collection(_collection));

    final resultSet = await query.execute();

    return await resultSet.asStream().map((result) {
      return Users.fromJson(result.toPlainMap());
    }).toList();
  }

  Future<void> add(Users users) async {
    final doc = MutableDocument(users.toJson());
    print(users.toJson());
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
