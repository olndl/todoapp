import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';

class SwitchOffIconWidget extends StatelessWidget {
  final TodoFormViewModel viewModel;


  SwitchOffIconWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () =>  _toSetDeadline(context),
      splashColor: Colors.transparent,
      child: SvgPicture.asset(
        S.iconSwitchOff,
      ),
    );
  }


  void _toSetDeadline(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: viewModel.initialDueDateValue() != null ? DateTime.fromMillisecondsSinceEpoch(viewModel.initialDueDateValue()!) : DateTime.now(),
      firstDate: viewModel.datePickerFirstDate(),
      lastDate: viewModel.datePickerLastDate(),
    );
    if (pickedDate != null) {
      //_dueDateTextFieldController.text =  DateFormat('dd MMMM yyyy').format(pickedDate);
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

