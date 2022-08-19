import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/model/todo.dart';
import '../viewmodel/todoform/todo_form_viewmodel.dart';

class TodoFormPage extends ConsumerStatefulWidget{
  final Todo? _todo;

  const TodoFormPage(this._todo);

  @override
  _TodoFormPageState createState() => _TodoFormPageState();
}

class _TodoFormPageState extends ConsumerState<TodoFormPage> {
  late final TodoFormViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();
  final _dueDateFormFocusNode = _DisabledFocusNode();
  late TextEditingController _dueDateTextFieldController;

  _TodoFormPageState();

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(todoFormViewModelProvider(widget._todo));
    _dueDateTextFieldController = TextEditingController(
      text: _viewModel.initialDueDateValue() !=null ? DateFormat('yyyy/MM/dd').format(DateTime.fromMillisecondsSinceEpoch(_viewModel.initialDueDateValue()!)) : 'No',
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
      appBar: AppBar(
        title: Text(_viewModel.appBarTitle()),
        actions: [
          if (_viewModel.shouldShowDeleteTodoIcon()) _buildDeleteTodoIconWidget(),
        ],
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFormWidget(),
          _buildSaveButtonWidget(),
        ],
      ),
    );
  }

  Widget _buildSaveButtonWidget() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final currentState = _formKey.currentState;
          if (currentState != null && currentState.validate()) {
            _viewModel.createOrUpdateTodo();
            Navigator.pop(context);
          }
        },
        child: const Text('Save'),
      ),
    );
  }

  Widget _buildFormWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTitleFormWidget(),
          const SizedBox(height: 16),
          //_buildDescriptionFormWidget(),
          //const SizedBox(height: 16),
          _buildDueDateFormWidget()
        ],
      ),
    );
  }

  Widget _buildTitleFormWidget() {
    return TextFormField(
      initialValue: _viewModel.initialTitleValue(),
      maxLength: 20,
      onChanged: (value) => _viewModel.setTitle(value),
      validator: (_) => _viewModel.validateTitle(),
      decoration: const InputDecoration(
        icon: Icon(Icons.edit),
        labelText: 'Title',
        helperText: 'Required',
        border: OutlineInputBorder(),
      ),
    );
  }


  Widget _buildDueDateFormWidget() {
    return TextFormField(
      focusNode: _dueDateFormFocusNode,
      controller: _dueDateTextFieldController,
      maxLength: 50,
      onTap: () => _showDatePicker(context),
      // onChanged: (_) => _showDatePicker(context),
      // //validator: (_) => _viewModel.validateDueDate(),
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today_rounded),
        labelText: 'DueDate',
        helperText: 'Required',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDeleteTodoIconWidget() {
    return IconButton(
      onPressed: () => _showConfirmDeleteTodoDialog(),
      icon: const Icon(Icons.delete),
    );
  }

  Future<DateTime?> _showDatePicker(final BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _viewModel.initialDueDateValue() != null ? DateTime.fromMillisecondsSinceEpoch(_viewModel.initialDueDateValue()!) : DateTime.now(),
      firstDate: _viewModel.datePickerFirstDate(),
      lastDate: _viewModel.datePickerLastDate(),
    );
    if (selectedDate != null) {
      _dueDateTextFieldController.text =  DateFormat('yyyy/MM/dd').format(selectedDate);
      _viewModel.setDueDate(selectedDate.millisecondsSinceEpoch);
    }

    return null;
  }

  // void _toSetDeadline() async {
  //   DateTime? pickedDate = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime.now(),
  //       lastDate: DateTime(2101));
  //   if (pickedDate != null) {
  //     setState(() {
  //       _datetime = pickedDate.millisecondsSinceEpoch;
  //     });
  //   } else {
  //     setState(() {
  //       _isSwitched = false;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(AllLocale.of(context).incorrectDate),
  //         ),
  //       );
  //     });
  //   }
  // }

  _showConfirmDeleteTodoDialog() async {
    final bool result = await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: const Text('Delete ToDo?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
    if (result) {
      _viewModel.deleteTodo();
      Navigator.pop(context);
    }
  }
}

class _DisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}


// class TodoFormPage extends ConsumerStatefulWidget {
//   final Todo? _todo;
//
//   const TodoFormPage(this._todo);
//
//   @override
//   _TodoFormPageState createState() => _TodoFormPageState();
// }
//
// class _TodoFormPageState extends ConsumerState<TodoFormPage> {
//   late final TodoFormViewModel _viewModel;
//   final _formKey = GlobalKey<FormState>();
//   final _dueDateFormFocusNode = _DisabledFocusNode();
//   late TextEditingController _dueDateTextFieldController;
//
//   _TodoFormPageState();
//
//   @override
//   void initState() {
//     super.initState();
//     _viewModel = ref.read(todoFormViewModelProvider(widget._todo));
//     _dueDateTextFieldController = TextEditingController(
//       text: DateFormat('yyyy/MM/dd').format(_viewModel.initialDueDateValue()),
//     );
//   }
//
//   @override
//   void dispose() {
//     _dueDateFormFocusNode.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(final BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_viewModel.appBarTitle()),
//         actions: [
//           if (_viewModel.shouldShowDeleteTodoIcon()) DeleteTodoIconWidget(viewModel: _viewModel,),
//         ],
//       ),
//       body: BodyWidget(),
//     );
//   }
// }
//
//
// class DeleteTodoIconWidget extends StatelessWidget {
//   final TodoFormViewModel viewModel;
//
//   const DeleteTodoIconWidget({Key? key, required this.viewModel}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () => _showConfirmDeleteTodoDialog(context),
//       icon: const Icon(Icons.delete),
//     );
//   }
//
//   _showConfirmDeleteTodoDialog(context) async {
//     final bool result = await showDialog(
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           content: const Text('Delete ToDo?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, false),
//               child: const Text('CANCEL'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, true),
//               child: const Text('DELETE'),
//             ),
//           ],
//         );
//       },
//     );
//     if (result) {
//       viewModel.deleteTodo();
//       Navigator.pop(context);
//     }
//   }
// }
//
//
//
// class _DisabledFocusNode extends FocusNode {
//   @override
//   bool get hasFocus => false;
// }
//
// class BodyWidget extends ConsumerWidget {
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container(
//       padding: const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 16),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           FormWidget(),
//           SaveButtonWidget(),
//         ],
//       ),
//     );
//   }
// }
//
// class SaveButtonWidget extends ConsumerWidget {
//   final TodoFormViewModel viewModel;
//
//   const SaveButtonWidget({Key? key, required this.viewModel}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           final currentState = formKey.currentState;
//           if (currentState != null && currentState.validate()) {
//             viewModel.createOrUpdateTodo();
//             Navigator.pop(context);
//           }
//         },
//         child: const Text('Save'),
//       ),
//     );
//   }
// }
//
// class FormWidget extends ConsumerWidget {
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TitleFormWidget(),
//           const SizedBox(height: 16),
//           // _buildDescriptionFormWidget(),
//           const SizedBox(height: 16),
//           DueDateFormWidget()
//         ],
//       ),
//     );
//   }
// }
//
// class TitleFormWidget extends ConsumerWidget {
//   final TodoFormViewModel viewModel;
//
//   const TitleFormWidget({Key? key, required this.viewModel}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return TextFormField(
//       initialValue: viewModel.initialTitleValue(),
//       maxLength: 20,
//       onChanged: (value) => viewModel.setTitle(value),
//       validator: (_) => viewModel.validateTitle(),
//       decoration: const InputDecoration(
//         icon: Icon(Icons.edit),
//         labelText: 'Title',
//         helperText: 'Required',
//         border: OutlineInputBorder(),
//       ),
//     );
//   }
// }
//
//
// class DueDateFormWidget extends ConsumerWidget {
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return TextFormField(
//       focusNode: _dueDateFormFocusNode,
//       controller: _dueDateTextFieldController,
//       maxLength: 50,
//       onTap: () => _showDatePicker(context),
//       onChanged: (value) => _viewModel.setTitle(value),
//       //validator: (_) => _viewModel.validateDescription(),
//       decoration: const InputDecoration(
//         icon: Icon(Icons.calendar_today_rounded),
//         labelText: 'DueDate',
//         helperText: 'Required',
//         border: OutlineInputBorder(),
//       ),
//     );
//   }
//
//   Future<DateTime?> _showDatePicker(final BuildContext context) async {
//     final selectedDate = await showDatePicker(
//       context: context,
//       initialDate: _viewModel.initialDueDateValue(),
//       firstDate: _viewModel.datePickerFirstDate(),
//       lastDate: _viewModel.datePickerLastDate(),
//     );
//     if (selectedDate != null) {
//       _dueDateTextFieldController.text = DateFormat('yyyy/MM/dd').format(selectedDate);
//       _viewModel.setDueDate(selectedDate);
//     }
//
//     return null;
//   }
// }