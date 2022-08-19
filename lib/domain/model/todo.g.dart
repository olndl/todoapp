// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      id: json['id'] as String,
      createdAt: json['created_at'] as int,
      title: json['text'] as String,
      lastUpdatedBy: json['last_updated_by'] as String,
      changedAt: json['changed_at'] as int,
      dueDate: json['deadline'] as int?,
      color: json['color'] as String?,
      isCompleted: json['done'] as bool,
      importance: json['importance'] as String,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'text': instance.title,
      'last_updated_by': instance.lastUpdatedBy,
      'changed_at': instance.changedAt,
      'deadline': instance.dueDate,
      'color': instance.color,
      'done': instance.isCompleted,
      'importance': instance.importance,
    };
