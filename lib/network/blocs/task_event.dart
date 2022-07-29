import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetTaskList extends TaskEvent {}

class DeleteTaskEvent extends TaskEvent {
  final int id;

  const DeleteTaskEvent(this.id);

  @override
  List<Object> get props => [id];
}
