import '../model/todo.dart';

abstract class CreateTodoUseCase {
  Future<Todo> execute(
      final int revision,
      final String title,
      final int? dueDate,
      final String importance,
  );
}
