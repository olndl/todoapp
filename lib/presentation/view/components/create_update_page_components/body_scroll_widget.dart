import 'package:flutter/cupertino.dart';
import '../../../../domain/model/todo.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';
import 'app_bar_widget.dart';
import 'body_form_widget.dart';

class BodyScrollWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;
  final Todo? todo;

  BodyScrollWidget({Key? key, required this.viewModel, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AppBarFormWidget(
          viewModel: viewModel,
        ),
        SliverToBoxAdapter(
          child: BodyFormWidget(
            viewModel: viewModel,
            todo: todo,
          ),
        )
      ],
    );
  }
}
