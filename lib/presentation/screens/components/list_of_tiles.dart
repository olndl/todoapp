import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/presentation/screens/components/short_todo.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/dimension.dart';
import 'list_of_todos.dart';

class ListOfTiles extends StatelessWidget {
  const ListOfTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListOfTodos(),
        ShortTodo()
      ],
    );
  }
}
