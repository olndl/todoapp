import 'dart:io';

import 'package:todoapp/data/datasource/todos_database.dart';
import 'package:todoapp/domain/model/todo.dart';
import 'package:todoapp/domain/model/todo_list.dart';

import '../../../core/constants/strings.dart';
import '../../../core/errors/logger.dart';
import '../local_database/local_todos_database_impl.dart';
import '../remote_database/dio/dio_client.dart';
import '../remote_database/remote_todos_database_impl.dart';

class SyncTodosDatabaseImpl extends TodosDatabase {
  final LocalTodosDatabaseImpl localTodos = LocalTodosDatabaseImpl();
  final RemoteTodosDatabaseImpl remoteTodos =
      RemoteTodosDatabaseImpl(dioClient: DioClient());

  @override
  Future<TodoList> allTodos() async {
    late TodoList currantTodos;
    try {
      currantTodos = await localTodos.allTodos();
    } catch (e) {
      logger.info(e);
    }
    return patchTodos(currantTodos, currantTodos.revision);
  }

  @override
  Future<void> deleteTodo(String id, int revision) async {
    try {
      await localTodos.deleteTodo(id, revision);
    } catch (e) {
      logger.info(e);
    }
    try {
      remoteTodos.deleteTodo(id, revision);
    } catch (e) {
      logger.info(e);
    }
  }

  @override
  Future<Todo> insertTodo(Todo todo, int revision) async {
    late Todo currantTodo;
    try {
      currantTodo = await localTodos.insertTodo(todo, revision);
    } catch (e) {
      logger.info(e);
    }
    try {
      remoteTodos.insertTodo(todo, revision);
    } catch (e) {
      logger.info(e);
    }
    return currantTodo;
  }

  @override
  Future<TodoList> patchTodos(TodoList todoList, int revision) async {
    TodoList mergedList = TodoList(revision: revision, status: 'ok', list: []);
    bool isOnline = await hasNetwork();
    if (isOnline) {
      try {
        mergedList = await remoteTodos.patchTodos(todoList, todoList.revision);
      } catch (e) {
        logger.info(e);
      }
    } else {
      mergedList = todoList;
    }
    return mergedList;
  }

  @override
  Future<void> updateTodo(Todo todo, int revision) async {
    try {
      await localTodos.updateTodo(todo, revision);
    } catch (e) {
      logger.info(e);
    }
    try {
      remoteTodos.updateTodo(todo, revision);
    } catch (e) {
      logger.info(e);
    }
  }
}

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup(S.api.host);
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}
