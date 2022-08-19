import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
      success: (content) => TodoListContainerWidget(todoList: content,),
      error: (_) => ErrorWidget(),
      orElse: () => const Expanded(child: Center(child: CircularProgressIndicator())),
    );
  }
}

class TodoListContainerWidget extends ConsumerWidget {
  final TodoList todoList;
  const TodoListContainerWidget({Key? key, required this.todoList,}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  SliverToBoxAdapter(
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
        child: TodoListWidget(todoList: todoList,),
      ),
    );
  }
}







class ErrorWidget extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text('An error has occurred!'),);
  }
}


class TodoListWidget extends ConsumerWidget {
  final TodoList todoList;
  const TodoListWidget({Key? key, required this.todoList,}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Column(
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
        ShortTodoWidget()
      ],
    );
  }
}

class TodoItemCardWidget extends ConsumerWidget {
  final Todo todo;
  const TodoItemCardWidget({Key? key, required this.todo,}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: Dismissible(
        key: Key(todo.id),
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



      InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      todo.dueDate == null ? 'No' : DateFormat('yyyy/MM/dd').format(DateTime.fromMillisecondsSinceEpoch(todo.dueDate!)),
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(height: 4),
                    // Text(
                    //   todo.description.isEmpty ? 'No Description' : todo.description,
                    //   style: Theme.of(context).textTheme.bodyText2,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              todo.isCompleted ? CheckedIconWidget(todo: todo) : UncheckedIconWidget(todo: todo),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TodoFormPage(todo),
          )),
    );
  }
}

class UncheckedIconWidget extends ConsumerWidget {
  final Todo todo;

  UncheckedIconWidget({Key? key, required this.todo,}) : super(key: key);

  final _todoListProvider = todoListViewModelStateNotifierProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkResponse(
      child: const Icon(Icons.radio_button_off_rounded, size: 24, color: Colors.grey),
      onTap: () => ref.read(_todoListProvider.notifier).completeTodo(todo),
      splashColor: Colors.transparent,
    );
  }
}

class CheckedIconWidget extends ConsumerWidget {
  final Todo todo;

  CheckedIconWidget({Key? key, required this.todo,}) : super(key: key);

  final _todoListProvider = todoListViewModelStateNotifierProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkResponse(
      child: const Icon(Icons.done, size: 24, color: Colors.lightGreen),
      onTap: () =>  ref.read(_todoListProvider.notifier).undoTodo(todo),
      splashColor: Colors.transparent,
    );
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

class ChipsBarWidget extends StatelessWidget {
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

  MySliverAppBar({required this.viewModel, required this.numberOfCompleteTodo, required this.expandedHeight});

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
            child:   InputChip(
              label: viewModel.isFilteredByAll() ? const Text('All') : const Text('Incomplete'),
              selected: viewModel.isFilteredByAll(),
              onSelected: (val) => val ? viewModel.filterByAll() : viewModel.filterByIncomplete(),
              selectedColor: viewModel.isFilteredByAll() ? Colors.lightGreen : Colors.grey,
            ),
            //
            // IconButton(
            //     onPressed: () {
            //       print("жмяк на нижний");
            //     },
            //     icon: Icon(Icons.visibility)),
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



