import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'created_at') required int createdAt,
    @JsonKey(name: 'text') required String text,
    @JsonKey(name: 'last_updated_by') required String lastUpdatedBy,
    @JsonKey(name: 'changed_at') required int changedAt,
    @JsonKey(name: 'deadline') required int? deadline,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'done') required bool done,
    @JsonKey(name: 'importance') required String importance,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  const Todo._();

  Todo complete() => copyWith(done: true);

  Todo incomplete() => copyWith(done: false);
}
