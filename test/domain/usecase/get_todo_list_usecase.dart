import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/core/constants/strings.dart';
import 'package:todoapp/domain/model/todo.dart';
import 'package:todoapp/domain/model/todo_list.dart';
import 'package:todoapp/domain/repository/todos_repository.dart';
import 'package:todoapp/domain/usecase/get_todo_list_usecase.dart';
import 'package:todoapp/domain/usecase/get_todo_list_usecase_impl.dart';
import '../../mock/domain/repository/todos_repository_mock.mocks.dart';

void main() {
  final TodosRepository repository = MockTodosRepository();
  final date = DateTime.now().millisecondsSinceEpoch;
  const importance = S.basic;
  final lastUpdatedBy = Platform.operatingSystem;
  final GetTodoListUseCase usecase = GetTodoListUseCaseImpl(repository);

  setUp(() {
    when(repository.getTodoList()).thenAnswer(
      (_) async => TodoList(
        list: [
          Todo(
            id: '1',
            text: 'text',
            done: false,
            deadline: date,
            createdAt: date,
            lastUpdatedBy: lastUpdatedBy,
            changedAt: date,
            importance: importance,
          ),
        ],
        status: 'ok',
        revision: 115,
      ),
    );
  });

  test('should return TodoList', () async {
    final expected = TodoList(
      list: [
        Todo(
          id: '1',
          text: 'text',
          done: false,
          deadline: date,
          createdAt: date,
          lastUpdatedBy: lastUpdatedBy,
          changedAt: date,
          importance: importance,
        ),
      ],
      status: 'ok',
      revision: 111,
    );
    final actual = await usecase.execute();
    expect(expected, actual);
    verify(repository.getTodoList()).called(1);
  });
}
