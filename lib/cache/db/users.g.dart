// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
  json['username'] as String,
  phone: json['phone'] as String?,
  birthday: json['birthday'] == null
      ? null
      : DateTime.parse(json['birthday'] as String),
)..id = json['id'] as String?;

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'phone': instance.phone,
  'birthday': instance.birthday?.toIso8601String(),
};
