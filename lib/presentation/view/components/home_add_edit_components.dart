import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/core/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/presentation/view/todo_add_edit_page.dart';
import '../../../core/constants/dimension.dart';
import '../../../core/constants/strings.dart';
import '../../../core/localization/l10n/all_locales.dart';
import '../../../domain/model/todo.dart';
import '../../viewmodel/todoform/todo_add_edit_viewmodel.dart';

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

class AppBarFormWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;

  const AppBarFormWidget({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: true,
      floating: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(
          S.iconClose,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            viewModel.createOrUpdateTodo();
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 15, top: 15),
            child: Text(
              AllLocale.of(context).save,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ],
    );
  }
}

class BodyFormWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;

  const BodyFormWidget({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleFormWidget(viewModel),
        ImportanceFormWidget(viewModel: viewModel),
        DueDateFormWidget(viewModel),
        const Divider(
          thickness: .8,
        ),
        DeleteTodoIconWidget(
          viewModel: viewModel,
        )
      ],
    );
  }
}

class FormWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;
  final GlobalKey formKey;

  FormWidget({Key? key, required this.viewModel, required this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TitleFormWidget(viewModel),
          const SizedBox(height: 16),
          DueDateFormWidget(viewModel)
        ],
      ),
    );
  }
}

class TitleFormWidget extends ConsumerWidget {
  final TodoFormViewModel viewModel;

  TitleFormWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.all(Dim.width(context) / 25),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        initialValue: viewModel.initialTitleValue(),
        minLines: 4,
        maxLines: 100,
        autofocus: true,
        onChanged: (value) => viewModel.setTitle(value),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(Dim.width(context) / 20),
            border: InputBorder.none,
            hintText: AllLocale.of(context).hintMessage),
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.left,
      ),
    );
  }
}

class ImportanceFormWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;

  ImportanceFormWidget({Key? key, required this.viewModel}) : super(key: key);

  String dropdownValue = S.low;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dim.width(context) / 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AllLocale.of(context).priority,
            textAlign: TextAlign.left,
          ),
          SizedBox(
            width: 106,
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                child: DropdownButton(
                  value: viewModel.initialImportanceValue(),
                  style: TextStyle(color: ColorApp.lightTheme.labelPrimary),
                  icon: const SizedBox.shrink(),
                  items: [
                    DropdownMenuItem(
                      value: S.low,
                      child: Text(AllLocale.of(context).low),
                    ),
                    DropdownMenuItem(
                      value: S.basic,
                      child: Text(AllLocale.of(context).basic),
                    ),
                    DropdownMenuItem(
                      value: S.important,
                      child: Text(
                        '!! ${AllLocale.of(context).important}',
                        style: TextStyle(
                          color: ColorApp.lightTheme.colorRed,
                        ),
                      ),
                    )
                  ],
                  onChanged: (String? newImportance) =>
                      viewModel.setImportance(newImportance!),
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: ColorApp.lightTheme.colorGrey,
          )
        ],
      ),
    );
  }
}

class DueDateFormWidget extends ConsumerStatefulWidget {
  final TodoFormViewModel viewModel;

  const DueDateFormWidget(this.viewModel);

  @override
  DueDateFormWidgetState createState() => DueDateFormWidgetState();
}

class DueDateFormWidgetState extends ConsumerState<DueDateFormWidget> {
  TextEditingController _dueDateTextFieldController = TextEditingController();
  late bool _switch;

  @override
  void initState() {
    super.initState();
    // _dueDateTextFieldController = TextEditingController(
    //   text: widget.viewModel.initialDueDateValue() != null ? DateFormat('yyyy/MM/dd')
    //       .format(DateTime.fromMillisecondsSinceEpoch(
    //       widget.viewModel.initialDueDateValue()!,),) : null,
    // );
    _switch = _dueDateTextFieldController.text.isNotEmpty;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dim.width(context) / 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AllLocale.of(context).completeDate,
                textAlign: TextAlign.left,
              ),
              widget.viewModel.initialDueDateValue() != null
                  ? Text(
                      DateFormat('dd MMMM yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              widget.viewModel.initialDueDateValue()!)),
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.button,
                    )
                  : const SizedBox.shrink()
            ],
          ),
          Switch(
              value: _switch,
              onChanged: (value) {
                setState(() {
                  _switch = value;
                });
                if (value) {
                  _dueDateTextFieldController.text =
                      _toSetDeadline(context) as String;
                } else {
                  _dueDateTextFieldController.clear();
                  widget.viewModel.setDueDate(null);
                }
              })

          // widget.viewModel.shouldShowSwitchOn()
          //       ? InkResponse(
          //   onTap: () => widget.viewModel.setDueDate(null),
          //   splashColor: Colors.transparent,
          //   child: SvgPicture.asset(S.iconSwitchOn),
          // )
          //       : InkResponse(
          //   onTap: () =>  _toSetDeadline(context),
          //   splashColor: Colors.transparent,
          //   child: SvgPicture.asset(
          //     S.iconSwitchOff,
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<String?> _toSetDeadline(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.viewModel.initialDueDateValue() != null
          ? DateTime.fromMillisecondsSinceEpoch(
              widget.viewModel.initialDueDateValue()!)
          : DateTime.now(),
      firstDate: widget.viewModel.datePickerFirstDate(),
      lastDate: widget.viewModel.datePickerLastDate(),
    );
    if (pickedDate != null) {
      widget.viewModel.setDueDate(pickedDate.millisecondsSinceEpoch);
      return DateFormat('dd MMMM yyyy').format(pickedDate);
    } else {
      widget.viewModel.setDueDate(null);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AllLocale.of(context).incorrectDate),
        ),
      );
      return null;
    }
  }
}

class SwitchOnIconWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;

  SwitchOnIconWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => viewModel.setDueDate(null),
      splashColor: Colors.transparent,
      child: SvgPicture.asset(S.iconSwitchOn),
    );
  }
}

class SwitchOffIconWidget extends StatelessWidget {
  final TextEditingController dueDateTextFieldController;
  final TodoFormViewModel viewModel;

  SwitchOffIconWidget({
    Key? key,
    required this.viewModel,
    required this.dueDateTextFieldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => _toSetDeadline(context),
      splashColor: Colors.transparent,
      child: SvgPicture.asset(
        S.iconSwitchOff,
      ),
    );
  }

  Future<void> _toSetDeadline(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: viewModel.initialDueDateValue() != null
          ? DateTime.fromMillisecondsSinceEpoch(
              viewModel.initialDueDateValue()!)
          : DateTime.now(),
      firstDate: viewModel.datePickerFirstDate(),
      lastDate: viewModel.datePickerLastDate(),
    );
    if (pickedDate != null) {
      dueDateTextFieldController.text =
          DateFormat('dd MMMM yyyy').format(pickedDate);
      viewModel.setDueDate(pickedDate.millisecondsSinceEpoch);
    } else {
      viewModel.setDueDate(null);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AllLocale.of(context).incorrectDate),
        ),
      );
    }
  }
}

class DisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class SaveButtonWidget extends ConsumerWidget {
  final TodoFormViewModel viewModel;
  final GlobalKey formKey;

  SaveButtonWidget({required this.viewModel, required this.formKey, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final currentState = formKey.currentState;
          if (currentState != null) {
            viewModel.createOrUpdateTodo();
            Navigator.pop(context);
          }
        },
        child: const Text('Save'),
      ),
    );
  }
}

class DeleteTodoIconWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;

  const DeleteTodoIconWidget({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => viewModel.shouldShowDeleteTodoIcon()
          ? _showConfirmDeleteTodoDialog(context)
          : {},
      child: Container(
        margin: EdgeInsets.all(Dim.width(context) / 25),
        child: Row(
          children: [
            SvgPicture.asset(
              S.iconDelete,
              color: viewModel.shouldShowDeleteTodoIcon()
                  ? ColorApp.lightTheme.colorRed
                  : ColorApp.lightTheme.colorGrey,
            ),
            SizedBox(
              width: Dim.width(context) / 23,
            ),
            Text(
              AllLocale.of(context).delete,
              style: TextStyle(
                  color: viewModel.shouldShowDeleteTodoIcon()
                      ? ColorApp.lightTheme.colorRed
                      : ColorApp.lightTheme.colorGrey),
            )
          ],
        ),
      ),
    );
  }

  _showConfirmDeleteTodoDialog(BuildContext context) async {
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
      viewModel.deleteTodo();
      Navigator.pop(context);
    }
  }
}
