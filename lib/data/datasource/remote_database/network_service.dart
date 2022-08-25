import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/constants/strings.dart';
import '../../../core/errors/logger.dart';
import '../../../domain/model/todo.dart';
import '../../../domain/model/todo_element.dart';
import '../../../domain/model/todo_list.dart';
import '../local_database/database_helper.dart';

class NetworkService {
  final _token = S.token;
  final _baseUrl = S.baseUrl;

  final _dio = Dio();
  var databaseFuture = DatabaseHelper.db.database;

  Future<TodoList> fetchTodosOnServer(Map bodyRequest, int revision) async {
    try {
      Response response = await _dio.patch(
        '$_baseUrl/list/',
        data: bodyRequest,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'X-Last-Known-Revision': '$revision'
          },
        ),
      );
      if (response.statusCode == 200) {
        return TodoList.fromJson(response.data);
      }
      return TodoList.fromJson(response.data);
    } catch (error, stacktrace) {
      throw Exception('Wrong! + $stacktrace');
    }
  }

  Future<TodoList> fetchTodos() async {
    late final TodoList listResponce;
    final Database database = await databaseFuture;
    try {
      Response response = await _dio.get(
        '$_baseUrl/list/',
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );
      if (response.statusCode == 200) {
        listResponce = TodoList.fromJson(response.data);
        //return TodoList.fromJson(response.data);
      }
      //return TodoList.fromJson(response.data);
    } on DioError catch (error, stacktrace) {
      final todoMap = await database.query(S.databaseName);
      final listObject = todoMap.map((todo) => Todo.fromJson(todo)).toList();
      listResponce = TodoList.fromJson(
          {'status': 'ok', 'revision': 1, 'list': listObject});
      //throw Exception('Data not found / Connection issue');
    }
    return listResponce;
  }

  Future<Todo> fetchOneTodo(String id) async {
    try {
      Response response = await _dio.get(
        '$_baseUrl/list/$id',
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );
      if (response.statusCode == 200) {
        return TodoElement.fromJson(response.data).element;
      }
      return TodoElement.fromJson(response.data).element;
    } catch (error, stacktrace) {
      throw Exception('Data not found / Connection issue');
    }
  }

  Future<void> changeTodo(Map bodyRequest, String? id, int revision) async {
    try {
      Response response = await _dio.put(
        '$_baseUrl/list/$id',
        data: bodyRequest,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'X-Last-Known-Revision': '$revision'
          },
        ),
      );
      if (response.statusCode == 200) {
        logger.info(
          'Success changed!',
        );
      }
    } catch (e) {
      logger.info(
        'Error updating todo: $e',
      );
    }
  }

  Future<Todo> addTodo(Map bodyRequest, int revision) async {
    try {
      Response response = await _dio.post(
        '$_baseUrl/list/',
        data: bodyRequest,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'X-Last-Known-Revision': '$revision'
          },
        ),
      );
      if (response.statusCode == 200) {
        return TodoElement.fromJson(response.data).element;
      } else {
        return Todo.fromJson(bodyRequest['list']);
      }
    } catch (e) {
      throw Exception("Cannot add / Connection issue");
    }
  }

  Future<void> deleteTodo(String id, int revision) async {
    try {
      Response response = await _dio.delete(
        '$_baseUrl/list/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'X-Last-Known-Revision': '$revision'
          },
        ),
      );
      if (response.statusCode == 200) {
        logger.info(
          'Todo deleted! - ${TodoElement.fromJson(response.data)}',
        );
      }
    } catch (e) {
      logger.info(
        'Error deleting todo: $e',
      );
    }
  }
}
