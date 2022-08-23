import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/presentation/view/components/todo_add_edit_page/text_form_widget.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';
import 'delete_button_widget.dart';
import 'duedate_form_widget.dart';
import 'importance_form_widget.dart';

class BodyFormWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;

  const BodyFormWidget({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormWidget(viewModel),
        ImportanceFormWidget(viewModel),
        DueDateFormWidget(viewModel),
        const Divider(
          thickness: .8,
        ),
        DeleteTodoIconWidget(
          viewModel: viewModel,
        )
      ],
    );
  }
}
