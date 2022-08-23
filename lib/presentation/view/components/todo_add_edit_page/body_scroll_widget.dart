import 'package:flutter/cupertino.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';
import 'app_bar_widget.dart';
import 'body_column_widget.dart';

class BodyWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;

  BodyWidget({Key? key, required this.viewModel}) : super(key: key);

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
          ),
        )
      ],
    );
  }
}