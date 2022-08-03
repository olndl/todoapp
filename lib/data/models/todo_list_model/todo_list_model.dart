import 'package:freezed_annotation/freezed_annotation.dart';
import '../todo/todo.dart';

part 'todo_list_model.freezed.dart';
part 'todo_list_model.g.dart';

@freezed
class TodoListModel with _$TodoListModel {
  const factory TodoListModel({
    required int revision,
    required String status,
    required List<Todo> list,
  }) = _TodoListModel;

  factory TodoListModel.fromJson(Map<String, dynamic> json) => _$TodoListModelFromJson(json);
}
