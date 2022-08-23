import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/presentation/view/components/todo_list_page/short_todo_widget.dart';
import 'package:todoapp/presentation/view/components/todo_list_page/todo_item_card_widget.dart';

import '../../../../core/constants/dimension.dart';
import '../../../../domain/model/todo_list.dart';

class TodoListWidget extends ConsumerWidget {
  final TodoList todoList;

  const TodoListWidget({
    Key? key,
    required this.todoList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(
            top: Dim.height(context) / 100,
            bottom: Dim.height(context) / 100,
          ),
          controller: ScrollController(),
          shrinkWrap: true,
          itemCount: todoList.length,
          itemBuilder: (_, final int index) {
            return TodoItemCardWidget(todo: todoList[index]);
          },
        ),
        ShortTodoWidget()
      ],
    );
  }
}
