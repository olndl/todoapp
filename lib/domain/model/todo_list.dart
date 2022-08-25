import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todoapp/domain/model/todo.dart';
import 'package:todoapp/domain/model/todo_element.dart';

part 'todo_list.freezed.dart';
part 'todo_list.g.dart';

@freezed
class TodoList with _$TodoList {
  const factory TodoList({
    @JsonKey(name: 'revision') required int revision,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'list') required List<Todo> list
  }) = _TodoList;

  factory TodoList.fromJson(Map<String, dynamic> json) => _$TodoListFromJson(json);

  const TodoList._();

  operator [](int index) => list[index];

  int get length => list.length;

  int get completedTodoCount => list.where((todo) => todo.done).length;

  TodoList addTodo(Todo todo) => copyWith(revision: revision + 1 ,list: [...list, todo]);

  TodoList updateTodo(Todo newTodo) => copyWith(revision: revision + 1, list: list.map((todo) => newTodo.id == todo.id ? newTodo : todo).toList());

  TodoList removeTodoById(String id) => copyWith(revision: revision + 1, list: list.where((todo) => todo.id != id).toList());

  TodoList getTodoById(String id) => copyWith(list: list.where((todo) => todo.id == id).toList());

  TodoList filterByCompleted() => copyWith(list: list.where((todo) => todo.done).toList());

  TodoList filterByIncomplete() => copyWith(list: list.where((todo) => !todo.done).toList());
}
