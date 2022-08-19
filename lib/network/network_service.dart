// import 'package:dio/dio.dart';
// import 'package:todoapp/data/models/todo_list_model/todo_list_model.dart';
// import 'package:todoapp/data/models/todo_model/todo_model.dart';
// import '../core/constants/strings.dart';
// import '../core/errors/logger.dart';
//
//
// class NetworkService {
//   final _token = S.token;
//   final _baseUrl = S.baseUrl;
//
//   final _dio = Dio();
//
//   Future<TodoListModel> fetchTodosOnServer(
//       Map bodyRequest, int revision) async {
//     try {
//       Response response = await _dio.patch('$_baseUrl/list/',
//           data: bodyRequest,
//           options: Options(headers: {
//             'Authorization': 'Bearer $_token',
//             'Content-Type': 'application/json',
//             'X-Last-Known-Revision': '$revision'
//           }));
//       if (response.statusCode == 200) {
//         return TodoListModel.fromJson(response.data);
//       } else {
//         logger.info(
//           'fetchTodosOnServerResponce:'
//           '${response.statusCode} : ${response.data.toString()}',
//         );
//       }
//       return TodoListModel.fromJson(response.data);
//     } catch (error, stacktrace) {
//       logger.info(
//         'Exception occured: '
//         ' $error stackTrace: $stacktrace',
//       );
//       throw Exception("Data not found / Connection issue");
//     }
//   }
//
//   Future<TodoListModel> fetchTodos() async {
//     try {
//       Response response = await _dio.get('$_baseUrl/list/',
//           options: Options(headers: {'Authorization': 'Bearer $_token'}));
//       if (response.statusCode == 200) {
//         return TodoListModel.fromJson(response.data);
//       } else {
//         logger.info(
//           'fetchTodosResponce:'
//           '${response.statusCode} : ${response.data.toString()}',
//         );
//       }
//       return TodoListModel.fromJson(response.data);
//     } catch (error, stacktrace) {
//       logger.info(
//         'Exception occured: '
//         ' $error stackTrace: $stacktrace',
//       );
//       throw Exception("Data not found / Connection issue");
//     }
//   }
//
//   Future<TodoModel> fetchOneTodo(String id) async {
//     try {
//       Response response = await _dio.get('$_baseUrl/list/$id',
//           options: Options(headers: {'Authorization': 'Bearer $_token'}));
//       if (response.statusCode == 200) {
//         return TodoModel.fromJson(response.data);
//       } else {
//         logger.info(
//           'fetchOneTodoResponce:'
//           '${response.statusCode} : ${response.data.toString()}',
//         );
//       }
//       return TodoModel.fromJson(response.data);
//     } catch (error, stacktrace) {
//       logger.info(
//         'Exception occurred: '
//         ' $error stackTrace: $stacktrace',
//       );
//       throw Exception("Data not found / Connection issue");
//     }
//   }
//
//   Future<bool?> changeTodo(Map bodyRequest, String id, int revision) async {
//     try {
//       Response response = await _dio.put('$_baseUrl/list/$id',
//           data: bodyRequest,
//           options: Options(headers: {
//             'Authorization': 'Bearer $_token',
//             'Content-Type': 'application/json',
//             'X-Last-Known-Revision': '$revision'
//           }));
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         logger.info(
//           'fetchOneTodoResponse:'
//           '${response.statusCode} : ${response.data.toString()}',
//         );
//         return false;
//       }
//     } catch (e) {
//       logger.info(
//         'Error updating todo: $e',
//       );
//     }
//   }
//
//   Future<bool?> addTodo(Map bodyRequest, int revision) async {
//     try {
//       Response response = await _dio.post('$_baseUrl/list/',
//           data: bodyRequest,
//           options: Options(headers: {
//             'Authorization': 'Bearer $_token',
//             'Content-Type': 'application/json',
//             'X-Last-Known-Revision': '$revision'
//           }));
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         logger.info(
//           'fetchOneTodoResponce:'
//           '${response.statusCode} : ${response.data.toString()}',
//         );
//         return false;
//       }
//     } catch (e) {
//       logger.info(
//         'Error updating todo: $e',
//       );
//     }
//     return null;
//   }
//
//   Future<bool?> deleteTodo(String id, int revision) async {
//     try {
//       Response response = await _dio.delete('$_baseUrl/list/$id',
//           options: Options(headers: {
//             'Authorization': 'Bearer $_token',
//             'Content-Type': 'application/json',
//             'X-Last-Known-Revision': '$revision'
//           }));
//       if (response.statusCode == 200) {
//         logger.info(
//           'Todo deleted! - ${TodoModel.fromJson(response.data)}',
//         );
//         return true;
//       } else {
//         logger.info(
//           'fetchOneTodoResponce:'
//           '${response.statusCode} : ${response.data.toString()}',
//         );
//         return false;
//       }
//     } catch (e) {
//       logger.info(
//         'Error deleting todo: $e',
//       );
//     }
//     return null;
//   }
// }
