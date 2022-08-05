import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/models/todo/todo.dart';
import '../../../network/repository.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final Repository repository;

  TodosCubit({required this.repository}) : super(TodosInitial());

  void updateTodoListOnServer(todoList, revision) {
    repository.fetchTodosOnServer(todoList, revision).then((tasModel) {
      emit(TodosLoaded(
        todos: tasModel.list,
        revision: tasModel.revision,
      ));
    });
  }

  void fetchTodos() {
    Timer(Duration(seconds: 3), () {
      repository.fetchTodos().then((todos) {
        emit(TodosLoaded(
          todos: todos.list,
          revision: todos.revision,
        ));
      });
    });
  }

  addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todos;
      final revision = currentState.revision;
      todoList.add(todo);
      repository.addTodo(todo, revision).then((isAdded) {
        if (isAdded != null) {
          emit(TodosLoaded(todos: todoList, revision: revision + 1));
        }
      });
    }
  }

  void changeCompletion(Todo todo, int revision) {
    final currentState = state;
    final Todo todoWithChangedCompletion = todo.copyWith(done: !todo.done);
    if (currentState is TodosLoaded) {
      final revision = currentState.revision;
      final todoList =
          currentState.todos.where((element) => element.id != todo.id).toList();
      todoList.add(todoWithChangedCompletion);
      repository
          .changeTodo(todoWithChangedCompletion, todo.id, revision)
          .then((isChanged) {
        if (isChanged!) {
          emit(TodosLoaded(todos: todoList, revision: revision + 1));
        }
      });
    }
  }

  void changeTodo(Todo todo,
      String message,
      String importance,
      int deadline,
      int revision) {
    final currentState = state;
    final Todo todoWithChangedText = todo.copyWith(text: message,
        importance: importance, deadline: deadline);
    if (currentState is TodosLoaded) {
      final revision = currentState.revision;
      final todoList =
      currentState.todos.where((element) => element.id != todo.id).toList();
      todoList.add(todoWithChangedText);
      repository
          .changeTodo(todoWithChangedText, todo.id, revision)
          .then((isChanged) {
        if (isChanged!) {
          emit(TodosLoaded(todos: todoList, revision: revision + 1));
        }
      });
    }
  }

  void deleteTodo(Todo todo, int revision) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final revision = currentState.revision;
      final todoList =
          currentState.todos.where((element) => element.id != todo.id).toList();
      repository.deleteTodo(todo.id, revision).then((isDeleted) {
        if (isDeleted!) {
          emit(TodosLoaded(todos: todoList, revision: revision + 1));
        }
      });
    }
  }
}

