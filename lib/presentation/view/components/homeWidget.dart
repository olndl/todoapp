import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/dimension.dart';
import '../../../core/constants/strings.dart';
import '../../../core/localization/l10n/all_locales.dart';
import '../../../domain/model/todo.dart';
import '../../../domain/model/todo_list.dart';
import '../../viewmodel/todolist/filter_kind_viewmodel.dart';
import '../../viewmodel/todolist/todo_list_viewmodel.dart';
import '../todo_form_page.dart';

class HomeWidget extends ConsumerWidget {
  HomeWidget({Key? key}) : super(key: key);

  final _filteredTodoListProvider = filteredTodoListProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(_filteredTodoListProvider).maybeWhen(
          success: (content) => TodoListContainerWidget(
            todoList: content,
          ),
          error: (_) => ErrorWidget(),
          orElse: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

class TodoListContainerWidget extends ConsumerWidget {
  final TodoList todoList;

  const TodoListContainerWidget({
    Key? key,
    required this.todoList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
        top: Dim.height(context) / 40,
        left: Dim.width(context) / 56,
        right: Dim.width(context) / 56,
        bottom: Dim.height(context) / 40,
      ),
      child: TodoListWidget(
        todoList: todoList,
      ),
    );
  }
}

class ErrorWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text('An error has occurred!'),
    );
  }
}

class TodoListWidget extends ConsumerWidget {
  final TodoList todoList;

  const TodoListWidget({
    Key? key,
    required this.todoList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(
              top: Dim.height(context) / 100,
              bottom: Dim.height(context) / 100),
          controller: ScrollController(),
          shrinkWrap: true,
          itemCount: todoList.length,
          itemBuilder: (_, final int index) {
            return TodoItemCardWidget(todo: todoList[index]);
          },
        ),
        //ShortTodoWidget()
      ],
    );
  }
}

class TodoItemCardWidget extends ConsumerWidget {
  final Todo todo;

  TodoItemCardWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final _todoListProvider = todoListViewModelStateNotifierProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: Dismissible(
          key: Key(todo.id),
          background: Container(
            color: ColorApp.lightTheme.colorGreen,
            alignment: Alignment.lerp(
                Alignment.centerLeft, Alignment.centerRight, .05),
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
              .05,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SvgPicture.asset(
                S.iconDelete,
                color: ColorApp.lightTheme.colorWhite,
              ),
            ),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              ref.read(_todoListProvider.notifier).completeTodo(todo);
              return false;
            } else {
              bool delete = true;
              final snackbarController =
                  ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '${AllLocale.of(context).deletedTask} ${todo.title}'),
                  action: SnackBarAction(
                      label: AllLocale.of(context).undo,
                      onPressed: () => delete = false),
                ),
              );
              await snackbarController.closed;
              return delete;
            }
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              ref.read(_todoListProvider.notifier).deleteTodo(todo.id);
            }
          },
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: todo.isCompleted
                            ? CheckedIconWidget(todo: todo)
                            : UncheckedIconWidget(todo: todo),
                      ),
                      Expanded(
                        flex: 6,
                        child: todo.isCompleted == true
                            ? Text(
                                todo.title,
                                style: Theme.of(context).textTheme.headline1,
                              )
                            : Row(
                                children: [
                                  PriorityIconWidget(
                                      importance: todo.importance),
                                  Text(
                                    todo.title,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            S.iconInfoOutline,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: SizedBox.shrink()
                      ),
                      Expanded(
                        flex: 6,
                        child:  todo.dueDate != null
                            ? Text(
                            DateFormat(S.dateFormat, 'ru').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  todo.dueDate!),
                            ),
                            style: Theme.of(context).textTheme.subtitle1)
                            : const SizedBox.shrink(),
                      ),
                      const Expanded(
                          flex: 1,
                          child: SizedBox.shrink()
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TodoFormPage(todo),
                )),
          )),
    );
  }
}

class UncheckedIconWidget extends ConsumerWidget {
  final Todo todo;

  UncheckedIconWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final _todoListProvider = todoListViewModelStateNotifierProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkResponse(
      onTap: () => ref.read(_todoListProvider.notifier).completeTodo(todo),
      splashColor: Colors.transparent,
      child: SvgPicture.asset(
        S.iconUncheckedNormTile,
        color: todo.importance == S.important
            ? ColorApp.lightTheme.colorRed
            : ColorApp.lightTheme.colorGrey,
      ),
    );
  }
}

class CheckedIconWidget extends ConsumerWidget {
  final Todo todo;

  CheckedIconWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final _todoListProvider = todoListViewModelStateNotifierProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkResponse(
      onTap: () => ref.read(_todoListProvider.notifier).undoTodo(todo),
      splashColor: Colors.transparent,
      child: SvgPicture.asset(
        S.iconCheckedTile,
        color: ColorApp.lightTheme.colorGreen,
      ),
    );
  }
}

class PriorityIconWidget extends StatelessWidget {
  final String importance;

  const PriorityIconWidget({Key? key, required this.importance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: SvgPicture.asset(S.iconPriority,
                    color: ColorApp.lightTheme.colorRed),
              )
            : const SizedBox.shrink());
  }
}

class ShortTodoWidgetWidget extends ConsumerWidget {
  final Todo todo;

  ShortTodoWidgetWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
    //   ListTile(
    //   leading: const SizedBox.shrink(),
    //   title: TextField(
    //     controller: _shortTodoController,
    //     onSubmitted: (text) {
    //       text.isNotEmpty
    //           ? BlocProvider.of<TodosCubit>(context)
    //           .addShortTodo(text)
    //           : ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text(
    //               AllLocale.of(context).emptyInput),
    //         ),
    //       );
    //       _shortTodoController.clear();
    //     },
    //     style: Theme.of(context).textTheme.bodyText1,
    //     decoration: InputDecoration(
    //         border: InputBorder.none,
    //         hintText: AllLocale.of(context).newShortTodo,
    //         hintStyle:
    //         Theme.of(context).textTheme.bodyText2),
    //   ),
    // );
  }
}

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TodoFormPage(null),
        ),
      ),
      child: const Icon(Icons.add),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  final _provider = filterKindViewModelStateNotifierProvider;

  @override
  Widget build(final BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final viewModel = ref.watch(_provider.notifier);
        ref.watch(_provider);
        return SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: MySliverAppBar(
              viewModel: viewModel,
              expandedHeight: 150,
              numberOfCompleteTodo: 5),
        );
      },
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final FilterKindViewModel viewModel;
  final int numberOfCompleteTodo;
  final double expandedHeight;

  MySliverAppBar(
      {required this.viewModel,
      required this.numberOfCompleteTodo,
      required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          color: ColorApp.lightTheme.backPrimary,
        ),
        AnimatedOpacity(
          opacity: shrinkOffset / expandedHeight,
          duration: const Duration(milliseconds: 150),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  AllLocale.of(context).title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: expandedHeight / 1.7 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 6,
          child: AnimatedOpacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            duration: const Duration(milliseconds: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AllLocale.of(context).title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 100,
                ),
                Text(
                  '${AllLocale.of(context).subtitle} $numberOfCompleteTodo',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          child: AnimatedContainer(
            padding: EdgeInsets.lerp(
              EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 1.3,
                  top: MediaQuery.of(context).size.height / 6.4),
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 1.3),
              progress,
            ),
            duration: const Duration(milliseconds: 150),
            child: InputChip(
              label: viewModel.isFilteredByAll()
                  ? const Text('All')
                  : const Text('Incomplete'),
              selected: viewModel.isFilteredByAll(),
              onSelected: (val) => val
                  ? viewModel.filterByAll()
                  : viewModel.filterByIncomplete(),
              selectedColor:
                  viewModel.isFilteredByAll() ? Colors.lightGreen : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
