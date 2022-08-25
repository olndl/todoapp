import 'package:todoapp/data/datasource/todos_database.dart';
import '../../../domain/model/todo.dart';
import '../../../domain/model/todo_list.dart';
import 'network_service.dart';

class RemoteTodosDatabaseImpl implements TodosDatabase {
  final NetworkService networkService;

  RemoteTodosDatabaseImpl({required this.networkService});


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

  @override
  Future<Todo> getTodo(String id) async {
    final todoElement = await networkService.fetchOneTodo(id);
    return todoElement;
  }

  @override
  Future<TodoList> patchTodos(TodoList todoList, int revision) async {
    final bodyRequest = {'status': 'ok', 'list': todoList.list};
    final fetchedTodos =
        await networkService.fetchTodosOnServer(bodyRequest, revision);
    return fetchedTodos;
  }
}
