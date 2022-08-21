import 'package:flutter/material.dart';
import 'components/home_list_components.dart';

class TodoListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarWidget(),
          SliverToBoxAdapter(child: HomeWidget(),)
        ],
      ),
      floatingActionButton: const FloatingActionButtonWidget(),
    );
  }
}