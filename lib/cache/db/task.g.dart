// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDetails _$TaskDetailsFromJson(Map<String, dynamic> json) =>
    TaskDetails(
        createTime: json['createTime'] == null
            ? null
            : DateTime.parse(json['createTime'] as String),
      )
      ..id = json['id'] as String?
      ..name = json['name'] as String?
      ..progress = (json['progress'] as num?)?.toDouble();

Map<String, dynamic> _$TaskDetailsToJson(TaskDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'progress': instance.progress,
      'createTime': instance.createTime?.toIso8601String(),
    };

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
  name: json['name'] as String?,
  progress: (json['progress'] as num?)?.toDouble(),
)..id = json['id'] as String?;

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'progress': instance.progress,
};
