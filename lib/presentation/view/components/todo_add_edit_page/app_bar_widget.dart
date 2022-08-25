import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';

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
            if (viewModel.initialTitleValue().isNotEmpty) {
              viewModel.createOrUpdateTodo();
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AllLocale.of(context).emptyInput),
                ),
              );
            }
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
