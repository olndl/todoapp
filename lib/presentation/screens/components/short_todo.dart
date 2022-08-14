import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/l10n/all_locales.dart';
import '../../bloc/list_todo/todos_cubit.dart';

class ShortTodo extends StatelessWidget {
  const ShortTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
