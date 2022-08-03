import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/constants/dimension.dart';
import 'package:todoapp/core/localization/l10n/all_locales.dart';
import '../../core/navigation/controller.dart';
import '../../core/navigation/routes.dart';
import '../../data/models/task_model.dart';
import '../../data/models/todo/todo.dart';
import '../../network/blocs/task_list/task_state.dart';
import '../bloc/list_todo/todos_cubit.dart';
import '../widgets/app_header.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // final TaskBloc _newBloc = TaskBloc();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _newBloc.add(GetTaskList());
  // }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (!(state is TodosLoaded))
          return Center(child: CircularProgressIndicator());
        final todos = state.todos;
        final revision = state.revision;
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
              child: Text(
                AllLocale.of(context).subtitle,
              ),
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
                  child:
                      _buildCard(context, scrollController, todos, revision)),
            ),
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context
                  .read<NavigationController>()
                  .navigateTo(Routes.ADD_TODO_ROUTE, arguments: revision);
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildCard(
      BuildContext context, controller, List<Todo> todos, int revision) {
    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.only(
          top: Dim.height(context) / 100, bottom: Dim.height(context) / 100),
      controller: controller,
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final item = todos[index];
        return ClipRRect(
            clipBehavior: Clip.hardEdge,
            child: _todoTile(index, item, revision));
      },
    );
  }

  Widget _todoTile(int index, Todo item, int revision) {
    return Dismissible(
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
          final snackbarController = ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('${AllLocale.of(context).deletedTask} ${item.text}'),
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
      child: _todoCard(item, revision),
    );
  }

  Widget _todoCard(Todo todo, int revision) {
    return ListTile(
        onTap: () {
          context
              .read<NavigationController>()
              .navigateTo(Routes.view, arguments: todo);
        },
        leading: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor:
                todo.importance == "important" ? Colors.red : Colors.grey,
          ),
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.green,
            value: todo.done,
            onChanged: (_) async {
              BlocProvider.of<TodosCubit>(context)
                  .changeCompletion(todo, revision);
            },
          ),
        ),
        horizontalTitleGap: 3,
        trailing: IconButton(
          onPressed: () {
            context.read<NavigationController>().navigateTo(
                Routes.ADD_TODO_ROUTE,
                arguments: {"todo": todo, "revision": revision});
          },
          icon: const Icon(Icons.info_outline),
        ),
        title: todo.done == true
            ? Text(
                todo.text,
                //style: Theme.of(context).textTheme.bodyText2,
                style: const TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey),
              )
            : Row(
                children: [
                  _priority(todo.importance),
                  Text(
                    todo.text,
                    //style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
        subtitle: todo.deadline != null
            ? Text(
                DateFormat('dd MMMM yyy', 'ru').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        todo.deadline * 1000)),
                style: TextStyle(color: Colors.grey))
            : null);
  }

  Widget _priority(String importance) {
    return importance == "basic"
        ? Icon(Icons.arrow_downward)
        : (importance == "important"
            ? Icon(
                Icons.priority_high_sharp,
                color: Colors.red,
              )
            : Text(""));
  }
}
