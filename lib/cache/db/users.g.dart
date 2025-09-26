// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersDetails _$UsersDetailsFromJson(Map<String, dynamic> json) =>
    UsersDetails(
        phone: json['phone'] as String?,
        birthday: json['birthday'] == null
            ? null
            : DateTime.parse(json['birthday'] as String),
      )
      ..id = json['id'] as String?
      ..username = json['username'] as String?
      ..nickname = json['nickname'] as String?;

Map<String, dynamic> _$UsersDetailsToJson(UsersDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
      'phone': instance.phone,
      'birthday': instance.birthday?.toIso8601String(),
    };

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
  username: json['username'] as String?,
  nickname: json['nickname'] as String?,
)..id = json['id'] as String?;

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'nickname': instance.nickname,
};
