import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  factory Todo({
    required String id,
    int? createdAt,
    required String text,
    String? lastUpdatedBy,
    int? changedAt,
    int? deadline,
    String? color,
    @Default(false) bool done,
    @Default("low") String importance,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
