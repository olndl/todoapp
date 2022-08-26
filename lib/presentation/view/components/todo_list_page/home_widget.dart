import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/presentation/view/components/todo_list_page/todo_list_card_widget.dart';
import 'package:todoapp/presentation/view/unknown_page.dart';

import '../../../viewmodel/todolist/todo_list_viewmodel.dart';

class HomeWidget extends ConsumerWidget {
  HomeWidget({Key? key}) : super(key: key);

  final _filteredTodoListProvider = filteredTodoListProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(_filteredTodoListProvider).maybeWhen(
          success: (content) => TodoListCardWidget(
            todoList: content,
          ),
          error: (e) => UnknownPage('$e'),
          orElse: () => const Center(
              heightFactor: 15, child: CircularProgressIndicator(),),
        );
  }
}
