import 'package:equatable/equatable.dart';
import 'package:todoapp/data/models/task_model.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetTaskList extends TaskEvent {}

class AddTask extends TaskEvent{
  final Task task;
  AddTask(this.task);

  @override
  List<Object> get props => [task];

}

class UpdateTask extends TaskEvent{
  final Task updateTask;
  UpdateTask(this.updateTask);

  @override
  List<Object> get props => [updateTask];

}

class DeleteTask extends TaskEvent{
  final Task deleteTask;
  DeleteTask(this.deleteTask);

  @override
  List<Object> get props => [deleteTask];

}

// class GetTask extends TaskEvent {
//   final String id;
//
//   const GetTask(this.id);
//
//   @override
//   List<Object> get props => [];
// }
//
// class DeleteTask extends TaskEvent {
//   final String id;
//
//   const DeleteTask(this.id);
//
//   @override
//   List<Object> get props => [id];
// }
