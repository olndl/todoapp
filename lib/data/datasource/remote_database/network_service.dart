import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/core/errors/logger.dart';

import '../../../core/constants/strings.dart';
import '../../../domain/model/todo.dart';
import '../../../domain/model/todo_element.dart';
import '../../../domain/model/todo_list.dart';
import '../local_database/db.dart';

class NetworkService {
  final _token = S.token;
  final _baseUrl = S.baseUrl;

  final _dio = Dio();
  var databaseFuture = DatabaseHelper.db.database;

  Future<TodoList> fetchTodosOnServer(Map bodyRequest, int revision) async {
    try {
      Response response = await _dio.patch('$_baseUrl/list/',
          data: bodyRequest,
          options: Options(headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'X-Last-Known-Revision': '$revision'
          },),);
      if (response.statusCode == 200) {
        return TodoList.fromJson(response.data);
      } else {
        print(
          'fetchTodosOnServerResponce:'
          '${response.statusCode} : ${response.data.toString()}',
        );
      }
      return TodoList.fromJson(response.data);
    } catch (error, stacktrace) {
      print(
        'Exception occured: '
        ' $error stackTrace: $stacktrace',
      );
      throw Exception('Data not found / Connection issue');
    }
  }

  Future<TodoList> fetchTodos() async {
    late final TodoList todoList;
    final Database database = await databaseFuture;
    try {
      Response response = await _dio.get('$_baseUrl/list/',
        options: Options(headers: {'Authorization': 'Bearer $_token'}),);
      if (response.statusCode == 200) {
        todoList = TodoList.fromJson(response.data);
      }
    } on DioError catch (e) {
      logger.info(e);
      final todoMap = await database.query(S.todoTableName);
      todoList = TodoList.fromJson(todoMap.last);
    }
    return todoList;
  }


  Future<TodoElement> fetchOneTodo(String id) async {
    try {
      Response response = await _dio.get('$_baseUrl/list/$id',
          options: Options(headers: {'Authorization': 'Bearer $_token'}),);
      if (response.statusCode == 200) {
        return TodoElement.fromJson(response.data);
      } else {
        print(
          'fetchOneTodoResponce:'
          '${response.statusCode} : ${response.data.toString()}',
        );
      }
      return TodoElement.fromJson(response.data);
    } catch (error, stacktrace) {
      print(
        'Exception occurred: '
        ' $error stackTrace: $stacktrace',
      );
      throw Exception('Data not found / Connection issue');
    }
  }

  Future<void> changeTodo(Map bodyRequest, String? id, int revision) async {
    try {
      Response response = await _dio.put('$_baseUrl/list/$id',
          data: bodyRequest,
          options: Options(headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'X-Last-Known-Revision': '$revision'
          },),);
      if (response.statusCode == 200) {
        print(
          'Success changed!',
        );
      } else {
        print(
          'fetchOneTodoResponse:'
          '${response.statusCode} : ${response.data.toString()}',
        );
      }
    } catch (e) {
      print(
        'Error updating todo: $e',
      );
    }
  }

  Future<Todo> addTodo(Map bodyRequest, int revision) async {
    print('bodyRequest: $bodyRequest, revision: $revision');
    // try {
      Response response = await _dio.post('$_baseUrl/list/',
          data: bodyRequest,
          options: Options(headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'X-Last-Known-Revision': '$revision'
          },),);
      if (response.statusCode == 200) {
        return TodoElement.fromJson(response.data).element;
      } else {
        print(
          'fetchOneTodoResponce:'
          '${response.statusCode} : ${response.data.toString()}',
        );
        return Todo.fromJson(bodyRequest['list']);
      }
    // } catch (e) {
    //   print(
    //     'Error adding todo: $e',
    //   );
    //   throw Exception("Cannot add / Connection issue");
    // }
  }

  Future<void> deleteTodo(String id, int revision) async {
    try {
      Response response = await _dio.delete('$_baseUrl/list/$id',
          options: Options(headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'X-Last-Known-Revision': '$revision'
          },),);
      if (response.statusCode == 200) {
        print(
          'Todo deleted! - ${TodoElement.fromJson(response.data)}',
        );
      } else {
        print(
          'fetchOneTodoResponce:'
          '${response.statusCode} : ${response.data.toString()}',
        );
      }
    } catch (e) {
      print(
        'Error deleting todo: $e',
      );
    }
  }
}
