import 'package:flutter/cupertino.dart';
import 'package:todoapp/presentation/view/components/create_update_page_components/text_form_widget.dart';

import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';
import 'deadline_form_widget.dart';

class FormWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;

  FormWidget({Key? key, required this.viewModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormWidget(viewModel),
        const SizedBox(height: 16),
        DeadlineFormWidget(viewModel)
      ],
    );
  }
}