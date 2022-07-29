import 'package:dio/dio.dart';
import '../data/models/task_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final _baseUrl = 'https://beta.mrdekk.ru/todobackend';

  String token = 'Anehull';
  
  Future<TaskModel> fetchTaskList() async {
    try{
      Response response = await _dio.get(
        '$_baseUrl/list/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }
        )
      );
      return TaskModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured $error stackTrace: $stacktrace');
      throw Exception("Data not found / Connection issue");
    }
  }
}