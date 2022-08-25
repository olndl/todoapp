import 'package:todoapp/domain/usecase/patch_todo_usecase.dart';
import '../model/todo_list.dart';
import '../repository/todos_repository.dart';


class PatchTodoListUseCaseImpl implements PatchTodoListUseCase {
  final TodosRepository _repository;

  const PatchTodoListUseCaseImpl(this._repository);

  @override
  Future<TodoList> execute(
      final int revision,
      final TodoList todoList,
      ) => _repository.patchTodoList(revision, todoList);
}
