import 'package:todoapp/data/datasource/remote_database/todos_database.dart';

import '../../../domain/model/todo.dart';
import '../../../domain/model/todo_list.dart';
import 'network_service.dart';


class TodosDatabaseImpl implements TodosDatabase {

  final NetworkService networkService;

  TodosDatabaseImpl({required this.networkService});


  @override
  Future<TodoList> allTodos() async {
    final todosRaw = await networkService.fetchTodos();
    return todosRaw;
  }


  @override
  Future<Todo> insertTodo(Todo todo, int revision) async {
    final bodeRequest = {'status': 'ok', 'element': todo.toJson()};
     final newTodo = await networkService.addTodo(bodeRequest, revision);
     return newTodo;
  }


  @override
  Future<void> updateTodo(Todo todo, int revision) async {
     final bodyRequest = {'status': 'ok', 'element': todo.toJson()};
     await networkService.changeTodo(bodyRequest, todo.id, revision);
  }

  @override
  Future<void> deleteTodo(String id, int revision) async {
    await networkService.deleteTodo(id, revision);
  }

}
