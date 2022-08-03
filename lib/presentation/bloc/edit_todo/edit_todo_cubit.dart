import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/presentation/bloc/list_todo/todos_cubit.dart';
import '../../../data/models/todo/todo.dart';
import '../../../network/repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final Repository repository;
  final TodosCubit todosCubit;

  EditTodoCubit({required this.repository, required this.todosCubit})
      : super(EditTodoInitial());

  void deleteTodo(Todo todo, int revision) {
    todosCubit.deleteTodo(todo, revision);
    emit(TodoEdited());
    }


  void updateTodo(Todo todo, String message, int revision) {
    print(message);
    if (message.isEmpty) {
      emit(EditTodoError(error: "Message is empty"));
      return;
    }
    todosCubit.changeTodoText(todo, message, revision);
    emit(TodoEdited());
  }
}


