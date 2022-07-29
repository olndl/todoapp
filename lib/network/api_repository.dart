import 'package:todoapp/network/api_provider.dart';

import '../data/models/task_model.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<TaskModel> fetchTaskList() {
    return _provider.fetchTaskList();
  }

  Future<TaskModel> fetchTask(int id) {
    return _provider.fetchTask(id);
  }
}

class NetworkError extends Error {}