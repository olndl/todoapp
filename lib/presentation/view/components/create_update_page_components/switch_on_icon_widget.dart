import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/strings.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';

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
