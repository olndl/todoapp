import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/domain/repository/todos_repository.dart';
import 'package:todoapp/domain/usecase/delete_todo_usecase.dart';
import 'package:todoapp/domain/usecase/delete_todo_usecase_impl.dart';
import 'package:uuid/uuid.dart';

import '../../mock/domain/repository/todos_repository_mock.mocks.dart';

void main() {
  final TodosRepository repository = MockTodosRepository();
  final DeleteTodoUseCase usecase = DeleteTodoUseCaseImpl(repository);
  final id = const Uuid().v4();
  const revision = 100;

  setUp(() {
    when(repository.deleteTodo(id, revision)).thenAnswer((_) async => {});
  });

  test('should return void', () async {
    await usecase.execute(id, revision);
    verify(repository.deleteTodo(id, revision)).called(1);
  });
}
