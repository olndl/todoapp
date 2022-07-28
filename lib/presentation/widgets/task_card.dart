import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/todo.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isChecked = false;
  int inst = 0;

  priority(inst) {
    switch (inst) {
      case 0:
        return  Text('');
      case 1:
        return  Icon(Icons.arrow_downward_sharp);
      case 2:
        return  Icon(Icons.back_hand_outlined, color: Colors.red,);
    }
  }

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
      title: isChecked == true
          ? Text(
              widget.todo.getTodoTitle(),
              //style: Theme.of(context).textTheme.bodyText2,
              style: const TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          : Row(
            children: [
              priority(widget.todo.prio),
              Text(
                  widget.todo.getTodoTitle(),
                  //style: Theme.of(context).textTheme.bodyText2,
                ),
            ],
          ),
      subtitle: (widget.todo.getDate() != null)
          ? Text(
              widget.todo.getDate()!,
              style: Theme.of(context).textTheme.subtitle1,
            )
          : null,
    );
  }
}
