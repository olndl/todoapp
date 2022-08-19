import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/todo.dart';
import '../todolist/todo_list_viewmodel.dart';

final todoFormViewModelProvider = Provider.autoDispose.family<TodoFormViewModel, Todo?>((ref, todo) {
  return TodoFormViewModel(ref.read, todo);
});

class TodoFormViewModel {
  late final TodoListViewModel _todoListViewModel;
  late String _id;
  late int _createdAt;
  String _title ='';
  late String _lastUpdatedBy;
  late int _changedAt;
  int? _dueDate;
  String? _color;
  late bool _isCompleted;
  late String _importance;
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
      _title = todo.title;
      _lastUpdatedBy = todo.lastUpdatedBy;
      _changedAt = todo.changedAt;
      _dueDate = todo.dueDate;
      _color = todo.color;
      _isCompleted = todo.isCompleted;
      _importance = todo.importance;
    }
  }

  createOrUpdateTodo() {
    if (_isNewTodo) {
      print('title: $_title dudate: $_dueDate');
      _todoListViewModel.addTodo(_title, _dueDate,
          // _color,
          // _isCompleted,
          // _importance
      );
    } else {
      final newTodo = Todo(
          id: _id,
          createdAt: _createdAt,
          title: _title,
          lastUpdatedBy: _lastUpdatedBy,
          changedAt: _changedAt,
          dueDate: _dueDate,
          color: _color,
          isCompleted: _isCompleted,
          importance: _importance);
      _todoListViewModel.updateTodo(newTodo);
    }
  }

  deleteTodo() {
    if (!_isNewTodo) _todoListViewModel.deleteTodo(_id);
  }

  String appBarTitle() => _isNewTodo ? 'Add ToDo' : 'Edit ToDo';

  String initialTitleValue() => _title;

  //String initialDescriptionValue() => _description;

  int? initialDueDateValue() => _dueDate;

  DateTime datePickerFirstDate() => DateTime.now();

  DateTime datePickerLastDate() => DateTime(2101);

  bool shouldShowDeleteTodoIcon() => !_isNewTodo;

  setTitle(final String value) => _title = value;

  //setDescription(final String value) => _description = value;

  setTodoStatus(final bool status) => _isCompleted = status;

  setDueDate(final int value) => _dueDate = value;

  String? validateTitle() {
    if (_title.isEmpty) {
      return 'Enter a title.';
    } else if (_title.length > 20) {
      return 'Limit the title to 20 characters.';
    } else {
      return null;
    }
  }

  // String? validateDescription() {
  //   if (_description.length > 100) {
  //     return 'Limit the description to 100 characters.';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validateDueDate() {
  //   if (_isNewTodo && _dueDate.isBefore(DateTime.now().millisecondsSinceEpoch)) {
  //     return "DueDate must be after today's date.";
  //   } else {
  //     return null;
  //   }
  // }
}
