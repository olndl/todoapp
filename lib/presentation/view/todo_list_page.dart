import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/core/constants/colors.dart';
import 'package:todoapp/presentation/view/components/todo_list_page/add_button_widget.dart';
import '../viewmodel/todolist/todo_list_viewmodel.dart';
import 'components/todo_list_page/app_bar_widget.dart';
import 'components/todo_list_page/home_widget.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(
          builder: (context, ref, _) {
            final todoListState =
                ref.watch(todoListViewModelStateNotifierProvider.notifier);
            ref.watch(todoListViewModelStateNotifierProvider);
            return RefreshIndicator(
              color: ColorApp.lightTheme.colorBlue,
              onRefresh: () {
                return todoListState.patchTodoList();
              },
              child: CustomScrollView(
                slivers: [
                  AppBarWidget(),
                  SliverToBoxAdapter(
                    child: HomeWidget(),
                  )
                ],
              ),
            );
          },
        ),
        floatingActionButton: const AddTodoButtonWidget(),
      ),
    );
  }
}
