import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/presentation/view/components/create_update_page_components/text_form_widget.dart';
import '../../../../domain/model/todo.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';
import 'deadline_form_widget.dart';
import 'delete_button_widget.dart';
import 'importance_form_widget.dart';

class BodyFormWidget extends StatelessWidget {
  final Todo? todo;
  final TodoFormViewModel viewModel;

  const BodyFormWidget({Key? key, required this.viewModel, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormWidget(viewModel),
        ImportanceFormWidget(todo: todo,),
        DeadlineFormWidget(viewModel),
        const Divider(
          thickness: .8,
        ),
        DeleteTodoWidget(
          viewModel: viewModel,
        )
      ],
    );
  }
}
