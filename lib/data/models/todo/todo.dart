import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  factory Todo({
    required String id,
    required int createdAt,
    required String text,
    required String lastUpdatedBy,
    required int changedAt,
    @Default(0) int deadline,
    @Default('') String color,
    required bool done,
    required String importance,
  }) = _Todo;

  static String _getShortTask(String text) {
    if (text.length > 30) {
      return '${text.substring(0, 30)}...';
    } else {
      return text;
    }
  }

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
