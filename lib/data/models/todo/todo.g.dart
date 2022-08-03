// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      id: json['id'] as String,
      createdAt: json['createdAt'] as int,
      text: json['text'] as String,
      lastUpdatedBy: json['lastUpdatedBy'] as String,
      changedAt: json['changedAt'] as int,
      deadline: json['deadline'] as int? ?? 0,
      color: json['color'] as String? ?? '',
      done: json['done'] as bool,
      importance: json['importance'] as String,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'text': instance.text,
      'lastUpdatedBy': instance.lastUpdatedBy,
      'changedAt': instance.changedAt,
      'deadline': instance.deadline,
      'color': instance.color,
      'done': instance.done,
      'importance': instance.importance,
    };
