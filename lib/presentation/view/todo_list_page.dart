import 'package:flutter/material.dart';
import 'package:todoapp/presentation/view/components/list_page_components/create_todo_button_widget.dart';
import 'components/list_page_components/app_bar_widget.dart';
import 'components/list_page_components/home_widget.dart';

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
      floatingActionButton: const CreateTodoButtonWidget(),
    );
  }
}
