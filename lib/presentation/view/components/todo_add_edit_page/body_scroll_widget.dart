import 'package:flutter/cupertino.dart';
import '../../../viewmodel/todo_add_edit/todo_add_edit_viewmodel.dart';
import 'app_bar_widget.dart';
import 'body_column_widget.dart';

class BodyScrollWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;

  const BodyScrollWidget({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AppBarFormWidget(
          viewModel: viewModel,
        ),
        SliverToBoxAdapter(
          child: BodyColumnWidget(
            viewModel: viewModel,
          ),
        )
      ],
    );
  }
}