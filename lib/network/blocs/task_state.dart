import 'package:equatable/equatable.dart';
import 'package:todoapp/data/models/task_model.dart';


abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final TaskModel taskModel;

  const TaskLoaded(this.taskModel);
}

class TaskFailedState extends TaskState {
  final String? message;

  const TaskFailedState(this.message);
}
