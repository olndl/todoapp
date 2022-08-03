import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    @JsonKey(name: 'created_at') required int createdAt,
    required String text,
    @JsonKey(name: 'last_updated_by') required String lastUpdatedBy,
    @JsonKey(name: 'changed_at') required int changedAt,
    required int? deadline,
    String? color,
    required bool done,
    required String importance,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

}

