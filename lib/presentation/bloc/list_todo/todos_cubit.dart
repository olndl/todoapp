import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import '../../../core/errors/logger.dart';
import '../../../data/models/todo/todo.dart';
import '../../../network/repository.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final Uuid uuid = const Uuid();
  final Repository repository;

  Box<Todo> todosBox = Hive.box('todo_box');

  TodosCubit({required this.repository}) : super(TodosInitial());

  void updateTodoListOnServer(todoList, revision) {
    repository.fetchTodosOnServer(todoList, revision).then((taskModel) {
      emit(TodosLoaded(
        todos: taskModel.list,
        revision: taskModel.revision,
      ));
    });
  }

  void fetchTodos() {
    repository.fetchTodos().then((todos) {
      emit(TodosLoaded(
        todos: todos.list,
        revision: todos.revision,
      ));
    });
  }


  addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      List<Todo> todoList = List.from(currentState.todos);
      final revision = currentState.revision;
      todoList.add(todo);
      repository.addTodo(todo, revision).then((isAdded) {
        if (isAdded != null) {
          todosBox.put(todo.id, todo);
          logger.info(
            'Add todo with key - ${todo.id}.\nNumber of todos: '
            '${todosBox.length}, current todos: ${todosBox.values}',
          );
          emit(TodosLoaded(todos: todoList, revision: revision + 1));
        }
      });
    }
  }

  void addShortTodo(String message) {
    final currentState = state;
    final shortTodo = Todo(
        id: uuid.v4(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        text: message,
        lastUpdatedBy: "123",
        changedAt: DateTime.now().millisecondsSinceEpoch,
        deadline: null,
        color: null,
        done: false,
        importance: 'low');
    if (currentState is TodosLoaded) {
      List<Todo> todoList = List.from(currentState.todos);
      final revision = currentState.revision;
      todoList.add(shortTodo);
      repository.addTodo(shortTodo, revision).then((isAdded) {
        if (isAdded != null) {
          todosBox.put(shortTodo.id, shortTodo);
          logger.info(
            'Add todo with key - ${shortTodo.id}.\nNumber of todos: '
            '${todosBox.length}, current todos: ${todosBox.values}',
          );
          emit(TodosLoaded(todos: todoList, revision: revision + 1));
        }
      });
    }
  }

  void changeCompletion(Todo todo, int revision) {
    final currentState = state;
    final Todo todoWithChangedCompletion = todo.copyWith(
        done: !todo.done, changedAt: DateTime.now().millisecondsSinceEpoch);
    if (currentState is TodosLoaded) {
      final revision = currentState.revision;
      final todoList =
          currentState.todos.where((element) => element.id != todo.id).toList();
      todoList.add(todoWithChangedCompletion);
      repository
          .changeTodo(todoWithChangedCompletion, todo.id, revision)
          .then((isChanged) {
        if (isChanged!) {
          todosBox.put(todo.id, todoWithChangedCompletion);
          logger.info(
            'Change todo completion with key - ${todo.id}.\nNumber of todos: '
            '${todosBox.length}, current todos: ${todosBox.values}',
          );
          emit(TodosLoaded(todos: todoList, revision: revision + 1));
        }
      });
    }
  }

  void changeTodo(Todo todo, String message, String importance, int? deadline,
      int revision) {
    final currentState = state;
    final Todo todoWithChanging = todo.copyWith(
        text: message,
        importance: importance,
        deadline: deadline,
        changedAt: DateTime.now().millisecondsSinceEpoch);
    if (currentState is TodosLoaded) {
      final revision = currentState.revision;
      final todoList =
          currentState.todos.where((element) => element.id != todo.id).toList();
      todoList.add(todoWithChanging);
      repository
          .changeTodo(todoWithChanging, todo.id, revision)
          .then((isChanged) {
        if (isChanged!) {
          todosBox.put(todo.id, todoWithChanging);
          logger.info(
            'Changed todo with key - ${todo.id}. \n Before: $todo/ After: $todoWithChanging'
            '\nNumber of todos: '
            '${todosBox.length}, current todos: ${todosBox.values}',
          );
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
          todosBox.delete(todo.id);
          logger.info(
            'Deleted todo with key - ${todo.id}. Number of todos: '
            '${todosBox.length}, current todos: ${todosBox.values}',
          );
          emit(TodosLoaded(todos: todoList, revision: revision + 1));
        }
      });
    }
  }
}
