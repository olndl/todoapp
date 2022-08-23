import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/constants/strings.dart';
import '../../../domain/model/todo.dart';

final todoImportanceProvider =
ChangeNotifierProvider<TodoImportanceProvider>((ref) => TodoImportanceProvider());

class TodoImportanceProvider extends ChangeNotifier {
  String _todoCategory = S.low;

  String get todoCategory => _todoCategory;

  categoryOnChanged(String value) {
    if (value.isEmpty) {
      return _todoCategory;
    }
    _todoCategory = value;
    return notifyListeners();
  }
}
