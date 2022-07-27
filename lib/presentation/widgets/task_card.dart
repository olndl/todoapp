import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/todo.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({Key? key, required this.todo}) : super(key: key);

  //final String text;
  final Todo todo;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          }),
      horizontalTitleGap: 3,
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.info_outline),
      ),
      title: Text(
        widget.todo.getTodoTitle(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      subtitle: (widget.todo.getDate() != '')
          ? Text(
              widget.todo.getDate(),
              style: Theme.of(context).textTheme.subtitle1,
            )
          : null,
    );
  }
}
