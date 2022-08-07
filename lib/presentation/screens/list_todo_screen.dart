import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/presentation/screens/view_todo_screen.dart';
import '../../core/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/dimension.dart';
import '../../core/errors/logger.dart';
import '../../core/localization/l10n/all_locales.dart';
import '../../core/navigation/routes.dart';
import '../../data/models/todo/todo.dart';
import '../bloc/list_todo/todos_cubit.dart';



class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  late TextEditingController _shortTodoController;

  @override
  void initState() {
    super.initState();
    _shortTodoController = TextEditingController();
  }

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (!(state is TodosLoaded)) {
          return const Center(child: CircularProgressIndicator());
        }
        List<Todo> todos = List.from(state.todos);
        todos.sort(compareElement);
        final revision = state.revision;
        final completeTodo =
            todos.where((element) => element.done == true).length;
        final uncompletedTodoList = todos.where((element) => element.done == false).toList();
        final scrollController = ScrollController();
        return Scaffold(
          backgroundColor: Color(0xfffcfaf1),
          body: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<TodosCubit>(context).updateTodoListOnServer(todos, revision);
              logger.info('current revision: $revision',);
            },
            color: ColorApp.lightTheme.colorWhite,
            backgroundColor: Colors.blue,
            strokeWidth: 4.0,
            child: CustomScrollView(
                slivers: [
              _head(),
              _subhead(context, completeTodo),
              _body(scrollController, context, flag ? todos : uncompletedTodoList, revision)
            ]),
          ),
          floatingActionButton: _btnAdd(revision, context),

          // Crash Example
          // floatingActionButton: TextButton(
          //   onPressed: () =>
          //   { FirebaseCrashlytics.instance.crash(),},
          //   child: const Text("Throw Test Exception"),
          // ),
        );
      },
    );
  }

  Widget _head() {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 84,
        maxHeight: 150,
        child:  IconButton(
          onPressed: () => {
          logger.info(
          "Button <eye> pressed"
          ),
            setState((){ flag = !flag;})},
          icon: flag == true
          ?  SvgPicture.asset(
            'assets/icons/visibility_off.svg',
            color: Colors.grey,
          )
              : SvgPicture.asset(
        'assets/icons/visibility.svg',
        color: Colors.grey,
        ),
      ),)
      );
  }

  Widget _subhead(context, num) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: Dim.width(context) / 4.95),
        child: Row(
          children: [
            Text(
              '${AllLocale.of(context).subtitle} $num',
            ),
          ],
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
            leading: SvgPicture.asset(
              'assets/icons/add.svg',
              color: Colors.transparent,
            ),
            title: TextField(
              controller: _shortTodoController,
              onSubmitted: (text) {
               text.isNotEmpty ? BlocProvider.of<TodosCubit>(context).addShortTodo(text)
               : ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                   content: Text('Error: - message is empty'),
                 ),
               );
                _shortTodoController.clear();
              },
              decoration: InputDecoration(border: InputBorder.none,
              hintText: AllLocale.of(context).newShortTodo),
            ),
          ),
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
              child: _todoBody(index, item, context, revision),);
        },
    );
  }

  Widget _todoBody(int index, Todo item, context, int revision) {
    return Dismissible(
      key: Key(item.id),
      background: _fromLeftToRight(),
      secondaryBackground: _fromRightToLeft(),
      confirmDismiss: (direction) =>
          _confirmDismissal(direction, context, item, revision),
      onDismissed: (direction) =>
          _toDismissed(direction, context, item, revision),
      child: _todoTile(item, context, revision),
    );
  }

  Widget _fromLeftToRight() {
    return Container(
      color: Colors.green,
      alignment: Alignment.lerp(Alignment.centerLeft, Alignment.centerRight, .05),
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
      alignment: Alignment.lerp(Alignment.centerRight, Alignment.centerLeft, .05),
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
      DismissDirection direction, context, Todo item, int revision) async {
    if (direction == DismissDirection.startToEnd) {
      BlocProvider.of<TodosCubit>(context).changeCompletion(item, revision);
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
          onPressed: () {_simpleDialogithTodoDetails(context, todo);},
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
                _fromTsoFormatDate(todo.deadline!),
                style: const TextStyle(color: Colors.grey))
            : null);
  }


  String _fromTsoFormatDate(int ts) {
    return DateFormat('dd MMMM yyy', 'ru').format(
        DateTime.fromMillisecondsSinceEpoch(ts));
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

  _simpleDialogithTodoDetails(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TodoViewScreen(todo: todo);
      },
    );
  }
  }

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);


  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: 1,
          child: ColoredBox(
            color: ColorApp.lightTheme.backPrimary,
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.lerp(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            const EdgeInsets.only(bottom: 16),
            progress,
          ),
          alignment: Alignment.lerp(
            const Alignment(0, 1),
            const Alignment(.5, 1.5),
            progress,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Text(
                  AllLocale.of(context).title,
                  style: TextStyle.lerp(
                    Theme.of(context)
                        .textTheme
                        .headline4,
                    Theme.of(context)
                        .textTheme
                        .headline6,
                    progress,
                  ),
                ),
              ),
              SizedBox(width: 95,),
              child
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}