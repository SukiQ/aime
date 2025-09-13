// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combat_power.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CombatPower _$CombatPowerFromJson(Map<String, dynamic> json) => CombatPower(
  username: json['username'] as String,
  firepower: (json['firepower'] as num).toInt(),
)..id = json['id'] as String;

Map<String, dynamic> _$CombatPowerToJson(CombatPower instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firepower': instance.firepower,
    };
