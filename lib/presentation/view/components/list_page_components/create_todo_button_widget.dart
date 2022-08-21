import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../todo_add_edit_page.dart';

class CreateTodoButtonWidget extends StatelessWidget {
  const CreateTodoButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TodoFormPage(null),
        ),
      ),
      child: const Icon(Icons.add),
    );
  }
}
