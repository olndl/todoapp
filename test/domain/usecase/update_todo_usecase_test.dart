import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/constants/strings.dart';
import 'package:todoapp/domain/repository/todos_repository.dart';
import 'package:todoapp/domain/usecase/update_todo_usecase.dart';
import 'package:todoapp/domain/usecase/update_todo_usecase_impl.dart';
import 'package:uuid/uuid.dart';

import '../../mock/domain/repository/todos_repository_mock.mocks.dart';

void main() {
  final TodosRepository repository = MockTodosRepository();
  final UpdateTodoUseCase usecase = UpdateTodoUseCaseImpl(repository);
  final date = DateTime.now().millisecondsSinceEpoch;
  final id = const Uuid().v4();
  const revision = 100;

  setUp(() {
    when(
      repository.updateTodo(
        revision,
        id,
        date,
        'title',
        'test',
        date,
        null,
        'color',
        true,
        'low',
      ),
    ).thenAnswer((_) async => {});
  });

  test('should return void', () async {
    await usecase.execute(
      revision,
      id,
      date,
      'title',
      'test',
      date,
      null,
      'color',
      true,
      S.api.low,
    );
    verify(
      repository.updateTodo(
        revision,
        id,
        date,
        'title',
        'test',
        date,
        null,
        'color',
        true,
        S.api.low,
      ),
    ).called(1);
  });
}
