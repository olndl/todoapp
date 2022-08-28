import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/constants/strings.dart';
import 'package:todoapp/domain/model/todo.dart';
import 'package:todoapp/domain/repository/todos_repository.dart';
import 'package:todoapp/domain/usecase/create_todo_usecase.dart';
import 'package:todoapp/domain/usecase/create_todo_usecase_impl.dart';

import '../../mock/domain/repository/todos_repository_mock.mocks.dart';

void main() {
  final TodosRepository repository = MockTodosRepository();
  final CreateTodoUseCase usecase = CreateTodoUseCaseImpl(repository);
  final date = DateTime.now().millisecondsSinceEpoch;
  final todo = Todo(
    id: '1',
    text: 'text',
    done: false,
    deadline: null,
    createdAt: date,
    lastUpdatedBy: 'test',
    changedAt: date,
    importance: S.api.low,
  );

  setUp(() {
    when(repository.createTodo(1, 'text', date, S.api.low))
        .thenAnswer((_) async => todo);
  });

  test('should return Todo', () async {
    final expected = await usecase.execute(1, 'text', date, S.api.low);
    final actual = todo;
    expect(expected, actual);
    verify(repository.createTodo(1, 'text', date, S.api.low));
  });
}
