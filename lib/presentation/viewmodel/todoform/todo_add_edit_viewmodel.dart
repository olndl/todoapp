import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/model/todo.dart';
import '../todolist/todo_list_viewmodel.dart';

final todoFormViewModelProvider =
    Provider.autoDispose.family<TodoFormViewModel, Todo?>((ref, todo) {
  return TodoFormViewModel(ref.read, todo);
});

class TodoFormViewModel {
  late final TodoListViewModel _todoListViewModel;
  late String _id;
  int _createdAt = DateTime.now().millisecondsSinceEpoch;
  String _title = '';
  String _lastUpdatedBy = '';
  int _changedAt = DateTime.now().millisecondsSinceEpoch;
  int? _dueDate;
  String? _color;
  bool _isCompleted = false;
  String _importance = 'low';
  bool _isNewTodo = false;

  TodoFormViewModel(final Reader read, final Todo? todo) {
    _todoListViewModel = read(todoListViewModelStateNotifierProvider.notifier);
    _initTodo(todo);
  }

  _initTodo(final Todo? todo) {
    if (todo == null) {
      _isNewTodo = true;
    } else {
      _id = todo.id;
      _createdAt = todo.createdAt;
      _title = todo.text;
      _lastUpdatedBy = todo.lastUpdatedBy;
      _changedAt = todo.changedAt;
      _dueDate = todo.deadline;
      _color = todo.color!;
      _isCompleted = todo.done;
      _importance = todo.importance;
    }
  }

  createOrUpdateTodo() {
    if (_isNewTodo) {
      _todoListViewModel.addTodo(
        _title,
        _dueDate,
        _importance,
      );
    } else {
      final newTodo = Todo(
        id: _id,
        createdAt: _createdAt,
        text: _title,
        lastUpdatedBy: _lastUpdatedBy,
        changedAt: _changedAt,
        deadline: _dueDate,
        color: _color,
        done: _isCompleted,
        importance: _importance,
      );
      _todoListViewModel.updateTodo(newTodo);
    }
  }

  deleteTodo() {
    if (!_isNewTodo) _todoListViewModel.deleteTodo(_id);
  }

  String initialTitleValue() => _title;

  String initialImportanceValue() => _importance;

  int? initialDueDateValue() => _dueDate;

  DateTime datePickerFirstDate() => DateTime.now();

  DateTime datePickerLastDate() => DateTime(2101);

  bool shouldShowDeleteTodoIcon() => !_isNewTodo;

  bool shouldShowSwitchOn() => _dueDate != null;

  setTitle(final String value) => _title = value;

  setTodoStatus(final bool status) => _isCompleted = status;

  setDueDate(final int? value) => _dueDate = value;

  setImportance(final String value) => _importance = value;
}
