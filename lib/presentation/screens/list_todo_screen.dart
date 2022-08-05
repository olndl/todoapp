import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../core/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/dimension.dart';
import '../../core/localization/l10n/all_locales.dart';
import '../../core/navigation/routes.dart';
import '../../data/models/todo/todo.dart';
import '../bloc/list_todo/todos_cubit.dart';
import '../widgets/app_header.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (!(state is TodosLoaded)) {
          return const Center(child: CircularProgressIndicator());
        }
        //List<Todo> todos = state.todos;
        List<Todo> todos = List.from(state.todos);
        todos.sort(compareElement);
        final revision = state.revision;
        final completeTodo =
            todos.where((element) => element.done == true).length;
        //final uncompletedTodo = todos.where((element) => element.done == false);
        final scrollController = ScrollController();
        return Scaffold(
          backgroundColor: Color(0xfffcfaf1),
          body: CustomScrollView(slivers: [
            _head(),
            _subhead(context, completeTodo),
            _body(scrollController, context, todos, revision)
          ]),
          floatingActionButton: _btnAdd(revision, context),
        );
      },
    );
  }

  Widget _head() {
    return const SliverPersistentHeader(
      pinned: true,
      delegate: AppHeader(),
    );
  }

  Widget _subhead(context, num) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: Dim.width(context) / 4.95),
        child: Text(
          '${AllLocale.of(context).subtitle} $num',
        ),
      ),
    );
  }

  Widget _body(ScrollController scrollController, context, List<Todo> todos,
      int revision) {
    return SliverToBoxAdapter(
        child: _card(scrollController, context, todos, revision));
  }

  Widget _card(ScrollController scrollController, context, List<Todo> todos,
      int revision) {
    return Card(
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
      child: Column(
        children: [
          _bodyCard(scrollController, context, todos, revision),
          ListTile(
            title: TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }

  int compareElement(Todo a, Todo b) =>
      DateTime.fromMillisecondsSinceEpoch(a.createdAt)
              .isAfter(DateTime.fromMillisecondsSinceEpoch(b.createdAt))
          ? -1
          : 1;

  Widget _bodyCard(controller, context, List<Todo> todos, int revision) {
    return ListView.builder(
      padding: EdgeInsets.only(
          top: Dim.height(context) / 100, bottom: Dim.height(context) / 100),
      controller: controller,
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final item = todos[index];
        return ClipRRect(
            clipBehavior: Clip.hardEdge,
            child: _todoBody(index, item, context, revision));
      },
    );
  }

  Widget _todoBody(int index, Todo item, context, int revision) {
    return Dismissible(
      key: Key(item.id),
      background: _fromLeftToRight(),
      secondaryBackground: _fromRightToLeft(),
      confirmDismiss: (direction) =>
          _confirmDismissal(direction, context, item),
      onDismissed: (direction) =>
          _toDismissed(direction, context, item, revision),
      child: _todoTile(item, context, revision),
    );
  }

  Widget _fromLeftToRight() {
    return Container(
      color: Colors.green,
      alignment: Alignment.centerLeft,
      child: Padding(
          padding: EdgeInsets.all(15),
          child: SvgPicture.asset(
            'assets/icons/check.svg',
            color: Colors.white,
          )),
    );
  }

  Widget _fromRightToLeft() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: SvgPicture.asset(
          'assets/icons/delete.svg',
          color: Colors.white,
        ),
      ),
    );
  }

  Future<bool> _confirmDismissal(
      DismissDirection direction, context, Todo item) async {
    if (direction == DismissDirection.startToEnd) {
      return false;
    } else {
      bool delete = true;
      final snackbarController = ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AllLocale.of(context).deletedTask} ${item.text}'),
          action: SnackBarAction(
              label: AllLocale.of(context).undo,
              onPressed: () => delete = false),
        ),
      );
      await snackbarController.closed;
      return delete;
    }
  }

  Future<bool?> _toDismissed(
      DismissDirection direction, context, Todo item, int revision) async {
    if (direction == DismissDirection.startToEnd) {
      BlocProvider.of<TodosCubit>(context).changeCompletion(item, revision);
      return false;
    }
    if (direction == DismissDirection.endToStart) {
      BlocProvider.of<TodosCubit>(context).deleteTodo(item, revision);
    }
  }

  Widget _todoTile(Todo todo, context, int revision) {
    bool isChanged = todo.done;
    return ListTile(
        onTap: () => Navigator.pushNamed(context, Routes.EDIT_TODO_ROUTE,
            arguments: {"todo": todo, "revision": revision}),
        leading: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor:
                todo.importance == "important" ? Colors.red : Colors.grey,
          ),
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.green,
            value: isChanged,
            onChanged: (_) async {
              BlocProvider.of<TodosCubit>(context)
                  .changeCompletion(todo, revision);
              //return false;
            },
          ),
        ),
        horizontalTitleGap: 3,
        trailing: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/info_outline.svg',
            color: Colors.grey,
          ),
        ),
        title: todo.done == true
            ? Text(
                todo.text,
                style: const TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey),
              )
            : Row(
                children: [
                  _priority(todo.importance),
                  Text(
                    todo.text,
                  ),
                ],
              ),
        subtitle: todo.deadline != null
            ? Text(
                DateFormat('dd MMMM yyy', 'ru').format(
                    DateTime.fromMillisecondsSinceEpoch(todo.deadline!)),
                style: const TextStyle(color: Colors.grey))
            : null);
  }

  Widget _priority(String? importance) {
    return importance == "basic"
        ? Padding(
            padding: const EdgeInsets.all(6.0),
            child: SvgPicture.asset(
              'assets/icons/arrow.svg',
              color: Colors.grey,
            ),
          )
        : (importance == "important"
            ? Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                  'assets/icons/priority.svg',
                  color: Colors.red,
                ),
              )
            : const Text(""));
  }

  Widget _btnAdd(int revision, context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, Routes.ADD_TODO_ROUTE,
          arguments: revision),
      child: SvgPicture.asset(
        'assets/icons/add.svg',
        color: Colors.white,
      ),
    );
  }
}

Widget _todoTile(Todo todo, context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(
          color: Colors.grey,
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(todo.text),
        _completionIndicator(todo),
      ],
    ),
  );
}

Widget _completionIndicator(Todo todo) {
  return Container(
    width: 20.0,
    height: 20.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
      border: Border.all(
        width: 4.0,
        color: todo.done ? Colors.green : Colors.red,
      ),
    ),
  );
}
