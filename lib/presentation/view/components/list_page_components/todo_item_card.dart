import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/presentation/view/components/list_page_components/priority_icon_widget.dart';
import 'package:todoapp/presentation/view/components/list_page_components/unchecked_icon_widget.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../../domain/model/todo.dart';
import '../../../viewmodel/todolist/todo_list_viewmodel.dart';
import '../../todo_add_edit_page.dart';
import 'checked_icon_widget.dart';

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
          alignment:
              Alignment.lerp(Alignment.centerLeft, Alignment.centerRight, .05),
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
                  '${AllLocale.of(context).deletedTask} ${todo.text}',
                ),
                action: SnackBarAction(
                  label: AllLocale.of(context).undo,
                  onPressed: () => delete = false,
                ),
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
                      child: todo.done
                          ? CheckedIconWidget(todo: todo)
                          : UncheckedIconWidget(todo: todo),
                    ),
                    Expanded(
                      flex: 6,
                      child: todo.done == true
                          ? Text(
                              todo.text,
                              style: Theme.of(context).textTheme.headline1,
                            )
                          : Row(
                              children: [
                                PriorityIconWidget(importance: todo.importance),
                                Text(
                                  todo.text,
                                  style: Theme.of(context).textTheme.bodyText1,
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
                    const Expanded(flex: 1, child: SizedBox.shrink()),
                    Expanded(
                      flex: 6,
                      child: todo.deadline != null
                          ? Text(
                              DateFormat(S.dateFormat, 'ru').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  todo.deadline!,
                                ),
                              ),
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          : const SizedBox.shrink(),
                    ),
                    const Expanded(flex: 1, child: SizedBox.shrink()),
                  ],
                ),
              ],
            ),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TodoFormPage(todo),
            ),
          ),
        ),
      ),
    );
  }
}
