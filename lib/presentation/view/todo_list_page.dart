import 'package:flutter/material.dart';
import 'package:todoapp/presentation/screens/components/main_header.dart';
import 'components/homeWidget.dart';

class TodoListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ChipsBarWidget(),
          HomeWidget()
        ],
      ),
      floatingActionButton: const FloatingActionButtonWidget(),

      //
      // appBar: AppBar(
      //   title: const Text('ToDo App'),
      // ),
      // body: Column(
      //   children: [
      //     ChipsBarWidget(),
      //     const Divider(height: 2, color: Colors.grey),
      //     HomeWidget()
      //   ],
      // ),
      // floatingActionButton: const FloatingActionButtonWidget(),
    );
  }
}