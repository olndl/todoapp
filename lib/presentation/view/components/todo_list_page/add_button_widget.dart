import 'package:flutter/material.dart';
import '../../../../core/navigation/routes.dart';

class AddTodoButtonWidget extends StatelessWidget {
  const AddTodoButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(
          context, Routes.addTodoRoute,),
      child: const Icon(Icons.add),
    );
  }
}
