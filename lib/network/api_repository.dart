import 'package:todoapp/network/api_provider.dart';

import '../data/models/task_model.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<TaskModel> fetchTaskList() {
    return _provider.fetchTaskList();
  }
}

class NetworkError extends Error {}