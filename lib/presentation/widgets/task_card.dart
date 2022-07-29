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
  late bool isChecked;

  priority(inst) {
    switch (inst) {
      case 'low':
        return Text('');
      case 'basic':
        return Icon(Icons.arrow_downward_sharp);
      case 'important':
        return const Icon(
          Icons.priority_high,
          color: Colors.red,
        );
    }
  }

  @override
  void initState() {
    super.initState();
    isChecked = widget.task.done;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: widget.task.importance == 'important'
                ? Colors.red
                : Colors.grey,
          ),
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.green,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ),
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
        subtitle: widget.task.deadline != null
            ? Text(
                DateFormat('dd MMMM yyy', 'ru').format(
                    DateTime.fromMillisecondsSinceEpoch(widget.task.deadline!)),
            style: TextStyle(color: Colors.grey)
              )
            : null);
  }
}
