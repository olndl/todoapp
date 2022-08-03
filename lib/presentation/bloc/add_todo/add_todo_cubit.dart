import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/models/todo/todo.dart';
import '../../../network/repository.dart';
import '../list_todo/todos_cubit.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final Repository repository;
  final TodosCubit todosCubit;

  AddTodoCubit({required this.repository, required this.todosCubit})
      : super(AddTodoInitial());

  void addTodo(Todo task, int revision) {
    print(task.text);
    if (task.text.isEmpty) {
      emit(AddTodoError(error: "Message is empty"));
      return;
    }
    emit(AddingTodo());
    todosCubit.addTodo(task);
    emit(TodoAdded());
  }
}