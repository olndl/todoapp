import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/task_model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  int inst = 0;

  priority(inst) {
    switch (inst) {
      case 'low':
        return Text('');
      case 'basic':
        return Icon(Icons.arrow_downward_sharp);
      case 'important':
        return Icon(
          Icons.back_hand_outlined,
          color: Colors.red,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = widget.task.done;
    return ListTile(
      leading: Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              //isChecked = value!;
            });
          }),
      horizontalTitleGap: 3,
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.info_outline),
      ),
      title: isChecked == true
          ? Text(
              widget.task.getShortTask(),
              //style: Theme.of(context).textTheme.bodyText2,
              style: const TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          : Row(
              children: [
                priority(widget.task.importance),
                Text(
                  widget.task.getShortTask(),
                  //style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
      subtitle: (widget.task.deadline != null)
          ? Text(
              "${DateFormat('dd-MMM-yyy').format(DateTime.fromMillisecondsSinceEpoch(widget.task.deadline))}",
              style: Theme.of(context).textTheme.subtitle1,
            )
          : null,
    );
  }
}
