import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/errors/logger.dart';
import '../../../../domain/model/todo.dart';
import '../../../../domain/model/todo_element.dart';
import '../../../../domain/model/todo_list.dart';
import '../../local_database/database_helper.dart';
import '../../requests/todo_list_responce.dart';
import 'authorization_interceptor.dart';
import 'dio_error.dart';

class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: S.api.baseUrl,
            connectTimeout: 3000,
            receiveTimeout: 3000,
            contentType: S.api.contentType,
            headers: {
              S.api.authHeader: S.api.authValue,
            },
            responseType: ResponseType.json,
          ),
        )..interceptors.add(AuthorizationInterceptor());

  late final Dio _dio;

  var databaseFuture = DatabaseHelper.db.database;

  Future<TodoList> fetchTodosOnServer(Map bodyRequest, int revision) async {
    try {
      _dio.options.headers[S.api.revisionHeader] = '$revision';
      Response response = await _dio.patch(
        '/list',
        data: bodyRequest,
      );
      return TodoList.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      logger.info(e);
      throw e.toString();
    }
  }

  Future<TodoList> fetchTodos() async {
    late final TodoList listResponce;
    final Database database = await databaseFuture;
    try {
      Response response = await _dio.get(
        '/list',
      );
      if (response.statusCode == 200) {
        listResponce = TodoList.fromJson(response.data);
      }
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      final todoMap = await database.query(S.sqflite.databaseName);
      final listObject = todoMap.map((todo) => Todo.fromJson(todo)).toList();
      listResponce = TodoListResponce(listObject).getResponce();
      throw errorMessage;
    } catch (e) {
      logger.info(e);
      throw e.toString();
    }
    return listResponce;
  }

  Future<Todo> fetchOneTodo(String id) async {
    try {
      Response response = await _dio.get(
        '/list/$id',
      );
      return TodoElement.fromJson(response.data).element;
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      logger.info(e);
      throw e.toString();
    }
  }

  Future<void> changeTodo(Map bodyRequest, String? id, int revision) async {
    try {
      _dio.options.headers[S.api.revisionHeader] = '$revision';
      await _dio.put(
        '/list/$id',
        data: bodyRequest,
      );
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      logger.info(e);
      throw e.toString();
    }
  }

  Future<Todo> addTodo(Map bodyRequest, int revision) async {
    try {
      _dio.options.headers[S.api.revisionHeader] = '$revision';
      Response response = await _dio.post(
        '/list/',
        data: bodyRequest,
      );
      return TodoElement.fromJson(response.data).element;
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      logger.info(e);
      throw e.toString();
    }
  }

  Future<void> deleteTodo(String id, int revision) async {
    try {
      _dio.options.headers[S.api.revisionHeader] = '$revision';
      await _dio.delete(
        '/list/$id',
      );
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      logger.info(e);
      throw e.toString();
    }
  }
}
