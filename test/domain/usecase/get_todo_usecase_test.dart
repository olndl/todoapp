import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/constants/strings.dart';
import 'package:todoapp/domain/model/todo.dart';
import 'package:todoapp/domain/model/todo_list.dart';
import 'package:todoapp/domain/repository/todos_repository.dart';
import 'package:todoapp/domain/usecase/get_todo_list_usecase.dart';
import 'package:todoapp/domain/usecase/get_todo_list_usecase_impl.dart';
import 'package:uuid/uuid.dart';

import '../../mock/domain/repository/todos_repository_mock.mocks.dart';

void main() {
  final TodosRepository repository = MockTodosRepository();
  final GetTodoListUseCase usecase = GetTodoListUseCaseImpl(repository);
  final id = const Uuid().v4();
  const revision = 100;
  final date = DateTime.now().millisecondsSinceEpoch;

  setUp(() {
    when(repository.getTodoList()).thenAnswer(
      (_) async => TodoList(
        list: [
          Todo(
            id: id,
            text: 'title',
            done: false,
            deadline: date,
            changedAt: date,
            createdAt: date,
            lastUpdatedBy: 'test',
            importance: S.api.low,
          ),
        ],
        revision: revision,
        status: 'ok',
      ),
    );
  });

  test('should return TodoList', () async {
    final expected = TodoList(
      list: [
        Todo(
          id: id,
          text: 'title',
          done: false,
          deadline: date,
          changedAt: date,
          createdAt: date,
          lastUpdatedBy: 'test',
          importance: S.api.low,
        ),
      ],
      revision: revision,
      status: 'ok',
    );
    final actual = await usecase.execute();
    expect(expected, actual);
    verify(repository.getTodoList()).called(1);
  });
}
