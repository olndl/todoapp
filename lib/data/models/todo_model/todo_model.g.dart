// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoModel _$$_TodoModelFromJson(Map<String, dynamic> json) => _$_TodoModel(
      revision: json['revision'] as int,
      status: json['status'] as String,
      element: Todo.fromJson(json['element'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TodoModelToJson(_$_TodoModel instance) =>
    <String, dynamic>{
      'revision': instance.revision,
      'status': instance.status,
      'element': instance.element,
    };
