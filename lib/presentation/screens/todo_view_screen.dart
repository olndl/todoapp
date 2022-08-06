import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/localization/l10n/all_locales.dart';
import '../../data/models/todo/todo.dart';

class TodoViewScreen extends StatelessWidget {
  final Todo todo;

  const TodoViewScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(AllLocale.of(context).todoView),
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("${AllLocale.of(context).task}: ${todo.text}"),
                Text("${AllLocale.of(context).createdAt}: ${todo.createdAt}"),
                Text("${AllLocale.of(context).changedAt}: ${todo.changedAt}"),
                Text("${AllLocale.of(context).deadline}: ${todo.deadline}"),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(AllLocale.of(context).ok),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
