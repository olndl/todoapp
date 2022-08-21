import 'package:flutter/material.dart';
import 'package:todoapp/presentation/view/components/list_page_components/todo_list_widget.dart';
import '../../../../core/constants/dimension.dart';
import '../../../../domain/model/todo_list.dart';

class TodoListContainerWidget extends StatelessWidget {
  final TodoList todoList;

  const TodoListContainerWidget({
    Key? key,
    required this.todoList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
        top: Dim.height(context) / 40,
        left: Dim.width(context) / 56,
        right: Dim.width(context) / 56,
        bottom: Dim.height(context) / 40,
      ),
      child: TodoListWidget(
        todoList: todoList,
      ),
    );
  }
}
