import 'package:flutter/material.dart';
import 'package:todoapp/presentation/view/components/list_page_components/short_todo_widget.dart';
import 'package:todoapp/presentation/view/components/list_page_components/todo_item_card.dart';
import '../../../../core/constants/dimension.dart';
import '../../../../domain/model/todo_list.dart';

class TodoListWidget extends StatelessWidget {
  final TodoList todoList;

  const TodoListWidget({
    Key? key,
    required this.todoList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
