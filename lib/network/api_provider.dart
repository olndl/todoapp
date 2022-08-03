import 'dart:convert';

import 'package:dio/dio.dart';
import '../data/models/task_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final _baseUrl = 'https://beta.mrdekk.ru/todobackend';

  String token = 'Anehull';

  Future<TaskModel> fetchTaskList() async {
    try {
      Response response = await _dio.get('$_baseUrl/list/',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        return TaskModel.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
      }
      return TaskModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured $error stackTrace: $stacktrace');
      throw Exception("Data not found / Connection issue");
    }
  }

  Future<Task> addTask(Task task, int revision) async {
    try {
      Response response = await _dio.post('$_baseUrl/list/',
          data: json.encode(task.toJson()),
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
              'X-Last-Known-Revision': revision,
            },
          ));
      if (response.statusCode == 200) {
        return Task.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw Exception("${response.statusCode}");
      }
    } catch (error, stacktrace) {
      print('Exception occured $error stackTrace: $stacktrace');
      throw Exception("Data not found / Connection issue");
    }
  }

  Future<Task> updateTask(Task task, int revision) async {
    try {
      Response response = await _dio.put('$_baseUrl/list//${task.id}',
          data: json.encode(task.toJson()),
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
              'X-Last-Known-Revision': revision,
            },
          ));
      if (response.statusCode == 200) {
        return Task.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw Exception("${response.statusCode}");
      }
    } catch (error, stacktrace) {
      print('Exception occured $error stackTrace: $stacktrace');
      throw Exception("Data not found / Connection issue");
    }
  }

  Future<Task> deleteTask(Task task, int revision) async {
    try {
      Response response = await _dio.delete('$_baseUrl/list/${task.id}',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
              'X-Last-Known-Revision': revision,
            },
          ));
      if (response.statusCode == 200) {
        return Task.fromJson(response.data);
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw Exception("${response.statusCode}");
      }
    } catch (error, stacktrace) {
      print('Exception occured $error stackTrace: $stacktrace');
      throw Exception("Data not found / Connection issue");
    }
  }
}
