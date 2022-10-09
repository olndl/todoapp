import '../model/todo.dart';
import '../repository/todos_repository.dart';
import 'create_todo_usecase.dart';

class CreateTodoUseCaseImpl implements CreateTodoUseCase {
  final TodosRepository _repository;

  const CreateTodoUseCaseImpl(this._repository);

  @override
  Future<Todo> execute(
      final int revision,
      final String title,
      final int? dueDate,
      final String importance,
  ) {
    return _repository.createTodo(
        revision,
        title,
        dueDate,
        importance,
    );
  }
}
