import 'package:flutter/material.dart';
import 'package:todoapp/presentation/view/components/todo_list_page/add_button_widget.dart';
import 'components/todo_list_page/app_bar_widget.dart';
import 'components/todo_list_page/home_widget.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarWidget(),
          SliverToBoxAdapter(
            child: HomeWidget(),
          )
        ],
      ),
      floatingActionButton: const AddTodoButtonWidget(),
    );
  }
}
