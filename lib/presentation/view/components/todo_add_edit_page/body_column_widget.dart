import 'package:flutter/material.dart';
import 'package:todoapp/presentation/view/components/todo_add_edit_page/text_form_widget.dart';

import '../../../../domain/model/todo.dart';
import '../../../viewmodel/todo_add_edit/todo_add_edit_viewmodel.dart';
import 'delete_button_widget.dart';
import 'duedate_form_widget.dart';
import 'importance_form_widget.dart';

class BodyColumnWidget extends StatelessWidget {
  final Todo? todo;
  final TodoFormViewModel viewModel;

  const BodyColumnWidget({Key? key, required this.viewModel, this.todo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormWidget(viewModel),
        ImportanceFormWidget(viewModel, todo),
        DueDateFormWidget(viewModel, todo),
        const Divider(
          thickness: .8,
        ),
        DeleteTodoIconWidget(
          viewModel: viewModel,
          todo: todo,
        )
      ],
    );
  }
}
