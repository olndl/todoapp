import 'package:todoapp/network/api_provider.dart';
import '../data/models/task_model.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<TaskModel> fetchTaskList() {
    return _provider.fetchTaskList();
  }
  Future<Task> addTask(Task task, int revision){
    return _provider.addTask(task, revision);
  }

  Future<Task> updateTask(Task task, int revision){
    return _provider.updateTask(task, revision);
  }

  Future<Task> deleteTask(Task task, int revision) {
    return _provider.deleteTask(task, revision);
  }
}

class NetworkError extends Error {}