import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
