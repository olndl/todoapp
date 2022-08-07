import 'package:todoapp/data/models/todo_list_model/todo_list_model.dart';
import 'package:todoapp/data/models/todo_model/todo_model.dart';

import '../data/models/todo/todo.dart';
import 'network_service.dart';

class Repository {
  final NetworkService networkService;

  Repository({required this.networkService});

  Future<TodoListModel> fetchTodosOnServer(
      List<Todo> taskList,
      int revision) async {
    final bodyRequest = {"status": "ok", "list": taskList};
    final fetchedTodos = await networkService.fetchTodosOnServer(bodyRequest, revision);
    return fetchedTodos;
}


  Future<TodoListModel> fetchTodos() async {
    final todosRaw = await networkService.fetchTodos();
    return todosRaw;
  }

  Future<bool?> changeTodo(
      Todo task,
      String id,
      int revision) async {
    final bodyRequest = {"status": "ok", "element": task.toJson()};
    final updatedTodo = await networkService.changeTodo(bodyRequest, id, revision);
    return updatedTodo;
  }

  Future<bool?> addTodo(
      Todo task,
      int revision) async {
    final bodeRequest = {"status": "ok", "element": task.toJson()};
    final newTodo = await networkService.addTodo(bodeRequest, revision);
    return newTodo;
  }

  Future<bool?> deleteTodo(
      String id,
      int revision) async {
    final deletedTodo = await networkService.deleteTodo(id, revision);
    return deletedTodo;
  }

}
