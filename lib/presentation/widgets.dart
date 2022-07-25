import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          value: false,
          onChanged: (bool? value) {
            setState(() {});
          }),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.info_outline),
      ),
      title: Text(
        widget.text,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
