// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoModel _$$_TodoModelFromJson(Map<String, dynamic> json) => _$_TodoModel(
      status: json['status'] as String,
      revision: json['revision'] as int,
      element: Todo.fromJson(json['element'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TodoModelToJson(_$_TodoModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'revision': instance.revision,
      'element': instance.element,
    };
