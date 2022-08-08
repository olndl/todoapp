import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/presentation/screens/view_todo_screen.dart';
import '../../core/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/dimension.dart';
import '../../core/constants/strings.dart';
import '../../core/errors/logger.dart';
import '../../core/localization/l10n/all_locales.dart';
import '../../core/navigation/routes.dart';
import '../../data/models/todo/todo.dart';
import '../bloc/list_todo/todos_cubit.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  bool flag = true;
  late TextEditingController _shortTodoController;

  final Map<String, dynamic> _availableImportanceColors = {
    "purple": ColorApp.lightTheme.colorSpecial,
    "red": ColorApp.lightTheme.colorRed,
  };

  final String _defaultImportanceColor = "red";
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> _initConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 1),
      minimumFetchInterval: const Duration(seconds: 10),
    ));

    _fetchConfig();
  }

  void _fetchConfig() async {
    await _remoteConfig.fetchAndActivate();
  }

  @override
  void initState() {
    super.initState();
    _shortTodoController = TextEditingController();
    _initConfig();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (state is! TodosLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        List<Todo> todos = List.from(state.todos);
        todos.sort(compareElement);
        final revision = state.revision;
        final completeTodo =
            todos.where((element) => element.done == true).length;
        final uncompletedTodoList =
            todos.where((element) => element.done == false).toList();
        final scrollController = ScrollController();
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<TodosCubit>(context)
                  .updateTodoListOnServer(todos, revision);
              logger.info(
                'current revision: $revision',
              );
            },
            strokeWidth: 4.0,
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _SliverAppBarDelegate(
                    minHeight: 84,
                    maxHeight: 150,
                    child: IconButton(
                      onPressed: () => {
                        setState(() {
                          flag = !flag;
                        })
                      },
                      icon: flag == true
                          ? SvgPicture.asset(
                              S.iconVisibilityOff,
                            )
                          : SvgPicture.asset(
                              S.iconVisibility,
                            ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: Dim.width(context) / 4.95),
                    child: Row(
                      children: [
                        Text(
                          '${AllLocale.of(context).subtitle} $completeTodo',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
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
                        ListView.builder(
                          padding: EdgeInsets.only(
                              top: Dim.height(context) / 100,
                              bottom: Dim.height(context) / 100),
                          controller: scrollController,
                          shrinkWrap: true,
                          itemCount:
                              flag ? todos.length : uncompletedTodoList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = flag
                                ? todos[index]
                                : uncompletedTodoList[index];
                            bool isChanged = item.done;
                            return ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              child: Dismissible(
                                key: Key(item.id),
                                background: Container(
                                  color: ColorApp.lightTheme.colorGreen,
                                  alignment: Alignment.lerp(
                                      Alignment.centerLeft,
                                      Alignment.centerRight,
                                      .05),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: SvgPicture.asset(
                                      S.iconCheck,
                                      color: ColorApp.lightTheme.colorWhite,
                                    ),
                                  ),
                                ),
                                secondaryBackground: Container(
                                  color: ColorApp.lightTheme.colorRed,
                                  alignment: Alignment.lerp(
                                      Alignment.centerRight,
                                      Alignment.centerLeft,
                                      .05),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: SvgPicture.asset(
                                      S.iconDelete,
                                      color: ColorApp.lightTheme.colorWhite,
                                    ),
                                  ),
                                ),
                                confirmDismiss: (direction) =>
                                    _confirmDismissal(
                                        direction, context, item, revision),
                                onDismissed: (direction) => _toDismissed(
                                    direction, context, item, revision),
                                child: ListTile(
                                    onTap: () => Navigator.pushNamed(
                                            context, Routes.EDIT_TODO_ROUTE,
                                            arguments: {
                                              "todo": item,
                                              "revision": revision
                                            }),
                                    leading: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: item
                                                    .importance ==
                                                S.important
                                            ? (_availableImportanceColors[
                                                _remoteConfig
                                                        .getString(
                                                            'importanceColor')
                                                        .isNotEmpty
                                                    ? _remoteConfig.getString(
                                                        'importanceColor')
                                                    : _defaultImportanceColor])
                                            : ColorApp.lightTheme.colorGrey,
                                      ),
                                      child: Checkbox(
                                        checkColor:
                                            ColorApp.lightTheme.colorWhite,
                                        activeColor:
                                            ColorApp.lightTheme.colorGreen,
                                        value: isChanged,
                                        onChanged: (_) async {
                                          BlocProvider.of<TodosCubit>(context)
                                              .changeCompletion(item, revision);
                                          //return false;
                                        },
                                      ),
                                    ),
                                    horizontalTitleGap: 8,
                                    trailing: IconButton(
                                      onPressed: () {
                                        _simpleDialogithTodoDetails(
                                            context, item);
                                      },
                                      icon: SvgPicture.asset(
                                        S.iconInfoOutline,
                                      ),
                                    ),
                                    title: item.done == true
                                        ? Text(
                                            item.text,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          )
                                        : Row(
                                            children: [
                                              _priority(item.importance),
                                              Text(
                                                item.text,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ],
                                          ),
                                    subtitle: item.deadline != null
                                        ? Text(
                                            _fromTsoFormatDate(item.deadline!),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1)
                                        : null),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: const SizedBox.shrink(),
                          title: TextField(
                            controller: _shortTodoController,
                            onSubmitted: (text) {
                              text.isNotEmpty
                                  ? BlocProvider.of<TodosCubit>(context)
                                      .addShortTodo(text)
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            AllLocale.of(context).emptyInput),
                                      ),
                                    );
                              _shortTodoController.clear();
                            },
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AllLocale.of(context).newShortTodo,
                                hintStyle:
                                    Theme.of(context).textTheme.bodyText2),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, Routes.ADD_TODO_ROUTE,
                arguments: revision),
            child: SvgPicture.asset(
              S.iconAdd,
            ),
          ),
        );
      },
    );
  }

  int compareElement(Todo a, Todo b) =>
      DateTime.fromMillisecondsSinceEpoch(a.createdAt)
              .isAfter(DateTime.fromMillisecondsSinceEpoch(b.createdAt))
          ? -1
          : 1;

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

  String _fromTsoFormatDate(int ts) {
    return DateFormat(S.dateFormat, 'ru')
        .format(DateTime.fromMillisecondsSinceEpoch(ts));
  }

  Widget _priority(String? importance) {
    return importance == S.basic
        ? Padding(
            padding: const EdgeInsets.all(6.0),
            child: SvgPicture.asset(
              S.iconArrow,
            ),
          )
        : (importance == S.important
            ? Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                  S.iconPriority,
                  color: _availableImportanceColors[
                      _remoteConfig.getString('importanceColor').isNotEmpty
                          ? _remoteConfig.getString('importanceColor')
                          : _defaultImportanceColor],
                ),
              )
            : const Text(""));
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
            const Alignment(-.4, .85),
            progress,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Text(
                  AllLocale.of(context).title,
                  style: TextStyle.lerp(
                    Theme.of(context).textTheme.headline5,
                    Theme.of(context).textTheme.headline6,
                    progress,
                  ),
                ),
              ),
              const SizedBox(
                width: 95,
              ),
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
