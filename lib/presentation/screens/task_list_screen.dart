import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/constants/dimension.dart';
import 'package:todoapp/core/localization/l10n/all_locales.dart';
import 'package:todoapp/presentation/widgets/task_card.dart';

import '../../core/navigation/controller.dart';
import '../../core/navigation/routes.dart';
import '../../data/models/todo.dart';
import '../widgets/app_header.dart';

class TaskHomeScreen extends StatefulWidget {
  const TaskHomeScreen({Key? key}) : super(key: key);

  @override
  State<TaskHomeScreen> createState() => _TaskHomeScreenState();
}

class _TaskHomeScreenState extends State<TaskHomeScreen> {
  var items = [
    Todo(datetime: DateTime.now().toString(), id:1, task: 'Сделать дз', prio: 0),
    Todo(datetime: null, id:2, task: 'Сдать проект', prio: 1),
    Todo(datetime: null, id:3, task: 'Сдать проект', prio: 2),
  ];

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scaffold(
      backgroundColor: Color(0xfffcfaf1),
      body: CustomScrollView(
          slivers: [
        const SliverPersistentHeader(
          pinned: true,
          delegate: AppHeader(),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.only(left: Dim.width(context) / 4.95),
          child: Text(AllLocale.of(context).subtitle),
        )),
        SliverToBoxAdapter(
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(
              top: Dim.height(context) / 40,
              left: Dim.width(context) / 56,
              right: Dim.width(context) / 56,
              bottom: Dim.height(context) / 40,
            ),
            child: ListView.builder(
              padding: EdgeInsets.only(
                  top: Dim.height(context) / 100,
                  bottom: Dim.height(context) / 100),
              controller: scrollController,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                return ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: Dismissible(
                      key: Key(item.task),
                      background: Container(
                          color: Colors.green,
                          alignment: Alignment.centerLeft,
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          )),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          setState(() {});
                          return false;
                        } else {
                          bool delete = true;
                          final snackbarController =
                              ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${AllLocale.of(context).deletedTask} ${item}'),
                              action: SnackBarAction(
                                  label: AllLocale.of(context).undo,
                                  onPressed: () => delete = false),
                            ),
                          );
                          await snackbarController.closed;
                          return delete;
                        }
                      },
                      onDismissed: (_) {
                        setState(() {
                          items.removeAt(index);
                        });
                      },
                      child: TaskCard(
                        key: ValueKey(index),
                        todo: item
                      ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NavigationController>().navigateTo(Routes.details);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
