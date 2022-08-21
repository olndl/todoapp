import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';

class SaveButtonWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;

  SaveButtonWidget({required this.viewModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          viewModel.createOrUpdateTodo();
          Navigator.pop(context);
        },
        child: const Text('Save'),
      ),
    );
  }
}
