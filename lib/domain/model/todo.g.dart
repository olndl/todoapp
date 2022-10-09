// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      id: json['id'] as String,
      createdAt: json['created_at'] as int,
      text: json['text'] as String,
      lastUpdatedBy: json['last_updated_by'] as String,
      changedAt: json['changed_at'] as int,
      deadline: json['deadline'] as int?,
      color: json['color'] as String?,
      done: json['done'] as bool,
      importance: json['importance'] as String,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'text': instance.text,
      'last_updated_by': instance.lastUpdatedBy,
      'changed_at': instance.changedAt,
      'deadline': instance.deadline,
      'color': instance.color,
      'done': instance.done,
      'importance': instance.importance,
    };
