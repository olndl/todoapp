import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/model/todo.dart';
import '../viewmodel/todoform/todo_add_edit_viewmodel.dart';
import 'components/home_add_edit_components.dart';

class TodoFormPage extends ConsumerStatefulWidget{
  final Todo? _todo;

  const TodoFormPage(this._todo);

  @override
  TodoFormPageState createState() => TodoFormPageState();
}

class TodoFormPageState extends ConsumerState<TodoFormPage> {
  late final TodoFormViewModel _viewModel;
  final _dueDateFormFocusNode = DisabledFocusNode();
  late TextEditingController _dueDateTextFieldController;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(todoFormViewModelProvider(widget._todo));
    _dueDateTextFieldController = TextEditingController(
      text: _viewModel.initialDueDateValue() != null ? DateFormat('yyyy/MM/dd')
          .format(DateTime.fromMillisecondsSinceEpoch(
          _viewModel.initialDueDateValue()!,),) : null,
    );
  }

  @override
  void dispose() {
    _dueDateFormFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: BodyWidget(viewModel: _viewModel,),
    );
  }

}
