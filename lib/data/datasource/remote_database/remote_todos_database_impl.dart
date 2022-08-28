import 'package:todoapp/data/datasource/requests/todo_list_request.dart';
import 'package:todoapp/data/datasource/requests/todo_request.dart';
import 'package:todoapp/data/datasource/todos_database.dart';

import '../../../domain/model/todo.dart';
import '../../../domain/model/todo_list.dart';
import 'dio/dio_client.dart';

class RemoteTodosDatabaseImpl implements TodosDatabase {
  final DioClient dioClient;

  RemoteTodosDatabaseImpl({required this.dioClient});

  @override
  Future<TodoList> allTodos() async {
    final todosRaw = await dioClient.fetchTodos();
    return todosRaw;
  }

  @override
  Future<Todo> insertTodo(Todo todo, int revision) async {
    final bodeRequest = TodoRequest(todo).getRequest();
    final newTodo = await dioClient.addTodo(bodeRequest, revision);
    return newTodo;
  }

  @override
  Future<void> updateTodo(Todo todo, int revision) async {
    final bodyRequest = TodoRequest(todo).getRequest();
    await dioClient.changeTodo(bodyRequest, todo.id, revision);
  }

  @override
  Future<void> deleteTodo(String id, int revision) async {
    await dioClient.deleteTodo(id, revision);
  }

  @override
  Future<TodoList> patchTodos(TodoList todoList, int revision) async {
    final bodyRequest = TodoListRequest(todoList.list).getRequest();
    final fetchedTodos =
        await dioClient.fetchTodosOnServer(bodyRequest, revision);
    return fetchedTodos;
  }
}
