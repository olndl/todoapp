import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  @HiveType(typeId: 0)
  const factory Todo({
    @HiveField(1) required String id,
    @JsonKey(name: 'created_at') @HiveField(2) required int createdAt,
    @HiveField(3) required String text,
    @JsonKey(name: 'last_updated_by') @HiveField(4) required String lastUpdatedBy,
    @JsonKey(name: 'changed_at') @HiveField(5) required int changedAt,
    @HiveField(6) required int? deadline,
    @HiveField(7) String? color,
    @HiveField(8) required bool done,
    @HiveField(9) required String importance,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

}

