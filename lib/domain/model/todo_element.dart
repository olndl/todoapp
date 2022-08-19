import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/domain/model/todo.dart';

part 'todo_element.freezed.dart';
part 'todo_element.g.dart';

@freezed
class TodoElement with _$TodoElement {
  const factory TodoElement({
    required int revision,
    required String status,
    required Todo element,
  }) = _TodoElement;

  const TodoElement._();

  factory TodoElement.fromJson(Map<String, dynamic> json) => _$TodoElementFromJson(json);
}
