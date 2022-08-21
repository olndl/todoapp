import 'package:todoapp/domain/usecase/update_todo_usecase.dart';
import '../repository/todos_repository.dart';

class UpdateTodoUseCaseImpl implements UpdateTodoUseCase {
  final TodosRepository _repository;

  const UpdateTodoUseCaseImpl(this._repository);

  @override
  Future<void> execute(
      final int revision,
      final String id,
      final int createdAt,
      final String title,
      final String lastUpdatedBy,
      final int changedAt,
      final int? dueDate,
      final String? color,
      final bool isCompleted,
      final String importance,
  ) {
    return _repository.updateTodo(revision, id, createdAt, title, lastUpdatedBy, changedAt, dueDate!, color!,
        isCompleted, importance);
  }
}
