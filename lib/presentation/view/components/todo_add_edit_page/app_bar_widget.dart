import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/core/errors/logger.dart';

import '../../../../core/constants/dimension.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../../core/navigation/model.dart';
import '../../../../core/navigation/provider.dart';
import '../../../viewmodel/todo_add_edit/todo_add_edit_viewmodel.dart';

class AppBarFormWidget extends ConsumerWidget {
  final TodoFormViewModel viewModel;

  const AppBarFormWidget({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      pinned: true,
      snap: true,
      floating: true,
      leading: IconButton(
        onPressed: () {
          ref.read(routerDelegateProvider).navigate([ListTodoSegment()]);
        },
        icon: Padding(
          padding: EdgeInsets.only(
            left: Dim.width(context) / 30,
          ),
          child: SvgPicture.asset(
            S.appIcons.iconClose,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            if (viewModel.initialTitleValue().isNotEmpty) {
              viewModel.createOrUpdateTodo();
              firebaseLogger(S.firebase.addLog, viewModel.initialTitleValue());
              ref.read(routerDelegateProvider).navigate([ListTodoSegment()]);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AllLocale.of(context).emptyInput),
                ),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              right: Dim.width(context) / 25,
              top: Dim.height(context) / 47,
            ),
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
