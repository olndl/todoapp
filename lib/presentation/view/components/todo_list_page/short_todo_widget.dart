import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../viewmodel/todolist/todo_list_viewmodel.dart';

class ShortTodoWidget extends ConsumerWidget {
  ShortTodoWidget({
    Key? key,
  }) : super(key: key);

  final TextEditingController _shortTodoController = TextEditingController();
  final _todoListProvider = todoListViewModelStateNotifierProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(flex: 1, child: SizedBox.shrink()),
              Expanded(
                flex: 6,
                child: TextField(
                  controller: _shortTodoController,
                  onSubmitted: (text) {
                    text.isNotEmpty
                        ? ref.read(_todoListProvider.notifier).addTodo(
                              text,
                              null,
                              S.low,
                            )
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AllLocale.of(context).emptyInput),
                            ),
                          );
                    _shortTodoController.clear();
                  },
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: AllLocale.of(context).newShortTodo,
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox.shrink()),
            ],
          ),
        ],
      ),
    );
  }
}
