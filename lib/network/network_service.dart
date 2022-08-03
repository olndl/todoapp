import 'package:dio/dio.dart';
import 'package:todoapp/data/models/todo_list_model/todo_list_model.dart';
import 'package:todoapp/data/models/todo_model/todo_model.dart';

class NetworkService {
  final token = "Anehull";
  final _baseUrl = "https://beta.mrdekk.ru/todobackend";

  final _dio = Dio();

  Future<TodoListModel> fetchTodosOnServer(Map bodyRequest, int revision) async {
    try {
      Response response = await _dio.patch(
          '$_baseUrl/list/',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'X-Last-Known-Revision': '$revision'
          }));
      if (response.statusCode == 200) {
        return TodoListModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
      }
      return TodoListModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured $error stackTrace: $stacktrace');
      throw Exception("Data not found / Connection issue");
    }
  }


  Future<TodoListModel> fetchTodos() async {
    try {
      Response response = await _dio.get('$_baseUrl/list/',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        return TodoListModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
      }
      return TodoListModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured $error stackTrace: $stacktrace');
      throw Exception("Data not found / Connection issue");
    }
  }

  Future<TodoModel> fetchOneTodo(String id) async {
    try {
      Response response = await _dio.get('$_baseUrl/list/$id',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        return TodoModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
      }
      return TodoModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured $error stackTrace: $stacktrace');
      throw Exception("Data not found / Connection issue");
    }
  }

  Future<bool?> changeTodo(Map bodyRequest, String id, int revision) async {
    try {
      Response response = await _dio.put('$_baseUrl/list/$id',
          data: bodyRequest,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'X-Last-Known-Revision': '$revision'
          }));
      if (response.statusCode == 200) {
        print(TodoModel.fromJson(response.data));
        return true;
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        return false;
      }
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<bool?> addTodo(Map bodyRequest, int revision) async {
    try {
      Response response = await _dio.post('$_baseUrl/list/',
          data: bodyRequest,
          options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'X-Last-Known-Revision': '$revision'
          }));
      if (response.statusCode == 200) {
        print(TodoModel.fromJson(response.data));
        return true;
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        return false;
      }
    } catch (e) {
      print('Error creating user: $e');
    }
    return null;
  }

  Future<bool?> deleteTodo(String id, int revision) async {
    try {
      Response response = await _dio.delete('$_baseUrl/list/$id',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'X-Last-Known-Revision': '$revision'
          }));
      if (response.statusCode == 200) {
        print('User deleted!');
        print(TodoModel.fromJson(response.data));
        return true;
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        return false;
      }
    } catch (e) {
      print('Error deleting user: $e');
    }
    return null;
  }
}
