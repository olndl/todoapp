import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/errors/logger.dart';
import '../../../../domain/model/todo.dart';
import '../../../viewmodel/todolist/todo_list_viewmodel.dart';

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
      key: const Key('complete_todo'),
      onTap: () {
        ref.read(_todoListProvider.notifier).completeTodo(todo);
        firebaseLogger(S.firebase.completeLog, todo.text);
      },
      splashColor: Colors.transparent,
      child: todo.importance == S.api.important
          ? SvgPicture.asset(S.appIcons.iconUncheckedHighTile)
          : SvgPicture.asset(
              S.appIcons.iconUncheckedNormTile,
              color: Theme.of(context).disabledColor,
            ),
    );
  }
}
