part of 'todos_cubit.dart';

abstract class TodosState {}

class TodosInitial extends TodosState {}
class TodosLoaded extends TodosState {
  final List<Todo> todos;
  final int revision;

  TodosLoaded({required this.revision, required this.todos});
}