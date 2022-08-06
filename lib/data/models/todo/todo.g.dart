// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<_$_Todo> {
  @override
  final int typeId = 0;

  @override
  _$_Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Todo(
      id: fields[1] as String,
      createdAt: fields[2] as int,
      text: fields[3] as String,
      lastUpdatedBy: fields[4] as String,
      changedAt: fields[5] as int,
      deadline: fields[6] as int?,
      color: fields[7] as String?,
      done: fields[8] as bool,
      importance: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Todo obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.lastUpdatedBy)
      ..writeByte(5)
      ..write(obj.changedAt)
      ..writeByte(6)
      ..write(obj.deadline)
      ..writeByte(7)
      ..write(obj.color)
      ..writeByte(8)
      ..write(obj.done)
      ..writeByte(9)
      ..write(obj.importance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
