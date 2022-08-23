import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/presentation/view/components/todo_list_page/todo_list_widget.dart';

import '../../../../core/constants/dimension.dart';
import '../../../../domain/model/todo_list.dart';

class TodoListContainerWidget extends ConsumerWidget {
  final TodoList todoList;

  const TodoListContainerWidget({
    Key? key,
    required this.todoList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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