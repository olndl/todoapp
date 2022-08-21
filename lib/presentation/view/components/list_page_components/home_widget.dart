import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/presentation/view/components/list_page_components/todo_list_container_widget.dart';
import '../../../viewmodel/todolist/todo_list_viewmodel.dart';

class HomeWidget extends ConsumerWidget {
  HomeWidget({Key? key}) : super(key: key);

  final _filteredTodoListProvider = filteredTodoListProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(_filteredTodoListProvider).maybeWhen(
          successRemote: (content) => TodoListContainerWidget(
            todoList: content,
          ),
          successLocal: (content) => TodoListContainerWidget(
            todoList: content,
          ),
          error: (e) => ErrorWidget(e),
          orElse: () => const Center(
            heightFactor: 20,
            child: CircularProgressIndicator(),
          ),
        );
  }
}
