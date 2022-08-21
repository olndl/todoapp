import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/presentation/view/components/create_update_page_components/body_scroll_widget.dart';
import '../../domain/model/todo.dart';
import '../viewmodel/todoform/todo_add_edit_viewmodel.dart';

class TodoFormPage extends ConsumerStatefulWidget {
  final Todo? _todo;

  const TodoFormPage(this._todo);

  @override
  TodoFormPageState createState() => TodoFormPageState();
}

class TodoFormPageState extends ConsumerState<TodoFormPage> {
  late final TodoFormViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(todoFormViewModelProvider(widget._todo));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: BodyScrollWidget(
        viewModel: _viewModel,
        todo: widget._todo,
      ),
    );
  }
}
