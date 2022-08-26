import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/model/todo.dart';
import '../viewmodel/todoform/todo_add_edit_viewmodel.dart';
import 'components/todo_add_edit_page/body_scroll_widget.dart';

class TodoFormPage extends ConsumerStatefulWidget{
  final Todo? _todo;

  const TodoFormPage(this._todo, {Key? key}) : super(key: key);

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
    return SafeArea(
      child: Scaffold(
        body: BodyWidget(viewModel: _viewModel,),
      ),
    );
  }

}
