import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/domain/model/todo.dart';

part 'todo_list.freezed.dart';
part 'todo_list.g.dart';

@freezed
class TodoList with _$TodoList {
  const factory TodoList({
    required int revision,
    required String status,
    @JsonKey(name: 'list') required List<Todo> values
  }) = _TodoList;

  factory TodoList.fromJson(Map<String, dynamic> json) => _$TodoListFromJson(json);

  const TodoList._();

  operator [](int index) => values[index];

  int get length => values.length;

  TodoList addTodo(Todo todo) => copyWith(revision: revision + 1 ,values: [...values, todo]);

  TodoList updateTodo(Todo newTodo) => copyWith(revision: revision + 1, values: values.map((todo) => newTodo.id == todo.id ? newTodo : todo).toList());

  TodoList removeTodoById(String id) => copyWith(revision: revision + 1, values: values.where((todo) => todo.id != id).toList());

  TodoList filterByCompleted() => copyWith(values: values.where((todo) => todo.isCompleted).toList());

  //int numberOfCompletedTodo() => filterByCompleted().length;

  TodoList filterByIncomplete() => copyWith(values: values.where((todo) => !todo.isCompleted).toList());
}
