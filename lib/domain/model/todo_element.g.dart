// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoElement _$$_TodoElementFromJson(Map<String, dynamic> json) =>
    _$_TodoElement(
      revision: json['revision'] as int,
      status: json['status'] as String,
      element: Todo.fromJson(json['element'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TodoElementToJson(_$_TodoElement instance) =>
    <String, dynamic>{
      'revision': instance.revision,
      'status': instance.status,
      'element': instance.element,
    };
