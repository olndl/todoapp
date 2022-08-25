import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../domain/model/todo.dart';
import '../../../viewmodel/todolist/todo_list_viewmodel.dart';

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