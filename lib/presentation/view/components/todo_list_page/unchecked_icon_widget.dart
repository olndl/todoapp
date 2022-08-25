import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/strings.dart';
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
      onTap: () => ref.read(_todoListProvider.notifier).completeTodo(todo),
      splashColor: Colors.transparent,
      child: SvgPicture.asset(
        todo.importance == S.important
            ? S.iconUncheckedHighTile
            : S.iconUncheckedNormTile,
      ),
    );
  }
}
