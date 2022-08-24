import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/domain/usecase/patch_todo_usecase.dart';
import '../../../domain/domain_module.dart';
import '../../../domain/model/todo.dart';
import '../../../domain/model/todo_list.dart';
import '../../../domain/usecase/create_todo_usecase.dart';
import '../../../domain/usecase/delete_todo_usecase.dart';
import '../../../domain/usecase/get_todo_list_usecase.dart';
import '../../../domain/usecase/update_todo_usecase.dart';
import '../../state/state.dart';
import 'filter_todo_viewmodel.dart';

final filteredTodoListProvider = Provider.autoDispose<State<TodoList>>((ref) {
  final filterKind = ref.watch(filterKindViewModelStateNotifierProvider);
  final todoListState = ref.watch(todoListViewModelStateNotifierProvider);

  return todoListState.when(
    init: () => const State.init(),
    success: (todoList) {
      switch (filterKind) {
        case FilterKind.all:
          return State.success(todoList);
        case FilterKind.completed:
          return State.success(
            todoList.filterByCompleted(),
          );
        case FilterKind.incomplete:
          return State.success(
            todoList.filterByIncomplete(),
          );
      }
    },
    loading: () => const State.loading(),
    error: (exception) => State.error(exception),
  );
});

final todoListViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<TodoListViewModel, State<TodoList>>(
        (ref) {
  return TodoListViewModel(
    ref.watch(getTodoListUseCaseProvider),
    ref.watch(createTodoUseCaseProvider),
    ref.watch(updateTodoUseCaseProvider),
    ref.watch(deleteTodoUseCaseProvider),
    ref.watch(patchTodoUseCaseProvider),
  );
});

class TodoListViewModel extends StateNotifier<State<TodoList>> {
  final GetTodoListUseCase _getTodoListUseCase;
  final CreateTodoUseCase _createTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;
  final PatchTodoListUseCase _patchTodoUseCase;

  TodoListViewModel(
    this._getTodoListUseCase,
    this._createTodoUseCase,
    this._updateTodoUseCase,
    this._deleteTodoUseCase,
      this._patchTodoUseCase,
  ) : super(const State.init()) {
    _getTodoList();
    getCountComplete();
  }

  completeTodo(final Todo todo) {
    final newTodo = todo.copyWith(done: true);
    updateTodo(newTodo);
  }

  undoTodo(final Todo todo) {
    final newTodo = todo.copyWith(done: false);
    updateTodo(newTodo);
  }

  _getTodoList() async {
    try {
      state = const State.loading();
      final todoList = await _getTodoListUseCase.execute();
      state = State.success(
        todoList,
      );
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  patchTodoList() async {
    try {
      final todoList = await _patchTodoUseCase.execute(
        state.data!.revision,
        state.data!,
      );
      state = State.success(
        todoList,
      );
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  getCountComplete() {
    return state.data?.completedTodoCount;
  }

  addTodo(
    final String title,
    final int? dueDate,
    final String importance,
  ) async {
    try {
      final newTodo = await _createTodoUseCase.execute(
        state.data!.revision,
        title,
        dueDate,
        importance,
      );
      state = State.success(
        state.data!.addTodo(newTodo),
      );
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  updateTodo(final Todo newTodo) async {
    try {
      await _updateTodoUseCase.execute(
        state.data!.revision,
        newTodo.id,
        newTodo.createdAt,
        newTodo.text,
        newTodo.lastUpdatedBy,
        newTodo.changedAt,
        newTodo.deadline ?? 0,
        newTodo.color ?? '',
        newTodo.done,
        newTodo.importance,
      );
      state = State.success(
        state.data!.updateTodo(newTodo),
      );
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  deleteTodo(final String id) async {
    try {
      await _deleteTodoUseCase.execute(
        id,
        state.data!.revision,
      );
      state = State.success(state.data!.removeTodoById(id));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }
}
