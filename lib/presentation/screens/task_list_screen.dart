import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/constants/dimension.dart';
import 'package:todoapp/core/localization/l10n/all_locales.dart';
import 'package:todoapp/network/blocs/task_bloc.dart';
import 'package:todoapp/network/blocs/task_event.dart';
import 'package:todoapp/presentation/widgets/task_card.dart';

import '../../core/navigation/controller.dart';
import '../../core/navigation/routes.dart';
import '../../data/models/task_model.dart';
import '../../network/blocs/task_state.dart';
import '../widgets/app_header.dart';

class TaskHomeScreen extends StatefulWidget {
  const TaskHomeScreen({Key? key}) : super(key: key);

  @override
  State<TaskHomeScreen> createState() => _TaskHomeScreenState();
}

class _TaskHomeScreenState extends State<TaskHomeScreen> {
  final TaskBloc _newBloc = TaskBloc();


  @override
  void initState() {
    super.initState();
    _newBloc.add(GetTaskList());
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scaffold(
      backgroundColor: Color(0xfffcfaf1),
      body: CustomScrollView(slivers: [
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
            child: BlocProvider(
              create: (_) => _newBloc,
              child: BlocListener<TaskBloc, TaskState>(
                listener: (context, state) {
                  if (state is TaskError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message!),
                      ),
                    );
                  }
                },
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskInitial) {
                      return _buildLoading();
                    } else if (state is TaskLoading) {
                      return _buildLoading();
                    } else if (state is TaskLoaded) {
                      return _buildCard(
                          context, scrollController, state.taskModel);
                    } else if (state is TaskError) {
                      return Container(
                        child: Center(
                          child: Text("${state.message}"),
                        ),
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Text("Что-то еще"),
                        ),
                      );
                    }
                  },
                ),
              ),
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

  Widget _buildCard(BuildContext context, controller, TaskModel model) {
    return ListView.builder(
      padding: EdgeInsets.only(
          top: Dim.height(context) / 100, bottom: Dim.height(context) / 100),
      controller: controller,
      shrinkWrap: true,
      itemCount: model.list.length,
      itemBuilder: (BuildContext context, int index) {
        final item = model.list[index];
        return ClipRRect(
          clipBehavior: Clip.hardEdge,
          child: Dismissible(
              key: Key(item.id),
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
                          '${AllLocale.of(context).deletedTask} ${item.text}'),
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
                  //items.removeAt(index);
                });
              },
              child: TaskCard(
                key: ValueKey(index),
                task: item,
              )),
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
