import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/strings.dart';
import '../../../domain/model/todo.dart';

final todoImportanceProvider =
    ChangeNotifierProvider.family<TodoImportanceProvider, Todo?>(
        (_, todo) => TodoImportanceProvider(todo));

class TodoImportanceProvider extends ChangeNotifier {
  final Todo? todo;

  TodoImportanceProvider(this.todo);

  String get todoCategory => todo != null ? todo!.importance : S.low;

  categoryOnChanged(String value, Todo? todo) {
    String todoCategory = todo != null ? todo.importance : S.low;
    if (value.isEmpty) {
      return todoCategory;
    }
    todoCategory = value;
    return notifyListeners();
  }
}
