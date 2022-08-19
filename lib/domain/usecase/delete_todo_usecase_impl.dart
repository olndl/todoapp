import '../repository/todos_repository.dart';
import 'delete_todo_usecase.dart';

class DeleteTodoUseCaseImpl implements DeleteTodoUseCase {
  final TodosRepository _repository;

  const DeleteTodoUseCaseImpl(this._repository);

  @override
  Future<void> execute(String id, int revision) => _repository.deleteTodo(id, revision);
}
