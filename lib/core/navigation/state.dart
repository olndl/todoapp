import 'package:flutter/cupertino.dart';

import '../../domain/model/todo.dart';

class NavigationState with ChangeNotifier {
  bool _isTodos;
  bool _todoIdCreate;
  Todo? _todoIdEdit;

  NavigationState(this._isTodos, this._todoIdCreate, this._todoIdEdit);

  bool get isTodos => _isTodos;

  bool get todoIdCreate => _todoIdCreate;

  Todo? get todoIdEdit => _todoIdEdit;

  set isTodos(bool val) {
    _isTodos = val;
    notifyListeners();
  }

  set todoIdCreate(bool val) {
    _todoIdCreate = val;
    notifyListeners();
  }

  set todoIdEdit(Todo? val) {
    _todoIdEdit = val;
    notifyListeners();
  }

  @override
  String toString() =>
      'ListTodos: $_isTodos, todoCreate: $_todoIdCreate, todoEdit: $_todoIdEdit';
}
