import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/domain/model/todo.dart';
import 'package:todoapp/domain/model/todo_list.dart';

void main() {
  group('[] operator', () {
    group('when index value is valid', () {
      test('should return specified todo', () {
        final actual = TodoList(list: [
          _buildTodo('0'),
          _buildTodo('1'),
          _buildTodo('2'),
          _buildTodo('3'),
        ], revision: 112, status: 'ok',)[2];
        final expected = _buildTodo('2');
        expect(actual, expected);
      });
    });

    group('when index value is invalid', () {
      test('should throw exception', () {
        final todoList = TodoList(list: [
          _buildTodo('0'),
          _buildTodo('1'),
          _buildTodo('2'),
          _buildTodo('3'),
        ], revision: 345, status: 'ok',);
        expect(() => todoList[4], throwsRangeError);
      });
    });
  });

  group('length getter', () {
    group('when todo list is empty', () {
      test('should return 0', () {
        final actual =
            const TodoList(list: [], status: 'ok', revision: 890).length;
        expect(actual, 0);
      });
    });

    group('when todo list is not empty', () {
      test('should return 2', () {
        final actual = TodoList(list: [
          _buildTodo('1'),
          _buildTodo('2'),
        ], status: 'ok', revision: 555,)
            .length;
        expect(actual, 2);
      });
    });
  });
}

Todo _buildTodo(final String id) {
  return Todo(
      id: id,
      createdAt: DateTime.parse('2021-09-10').millisecondsSinceEpoch,
      text: 'text$id',
      lastUpdatedBy: 'lastUpdatedBy$id',
      changedAt: DateTime.parse('2021-09-12').millisecondsSinceEpoch,
      deadline: DateTime.parse('2021-09-15').millisecondsSinceEpoch,
      done: false,
      importance: 'importance$id',);
}
