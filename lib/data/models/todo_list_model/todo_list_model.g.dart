// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoListModel _$$_TodoListModelFromJson(Map<String, dynamic> json) =>
    _$_TodoListModel(
      revision: json['revision'] as int,
      status: json['status'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TodoListModelToJson(_$_TodoListModel instance) =>
    <String, dynamic>{
      'revision': instance.revision,
      'status': instance.status,
      'list': instance.list,
    };
