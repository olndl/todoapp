import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todoapp/presentation/view/components/todo_list_page/short_todo_widget.dart';
import 'package:todoapp/presentation/view/components/todo_list_page/todo_item_card_widget.dart';

import '../../../../core/constants/dimension.dart';
import '../../../../domain/model/todo_list.dart';

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
        AnimationLimiter(
          child: ListView.builder(
            padding: EdgeInsets.only(
              top: Dim.height(context) / 100,
              bottom: Dim.height(context) / 100,
            ),
            controller: ScrollController(),
            shrinkWrap: true,
            itemCount: todoList.length,
            itemBuilder: (_, final int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 1000),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: TodoItemCardWidget(todo: todoList[index]),
                  ),
                ),
              );
            },
          ),
        ),
        ShortTodoWidget()
      ],
    );
  }
}
