import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimension.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/errors/logger.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../../core/navigation/model.dart';
import '../../../../core/navigation/provider.dart';
import '../../../../domain/model/todo.dart';
import '../../../viewmodel/todo_add_edit/todo_add_edit_viewmodel.dart';

class DeleteTodoIconWidget extends ConsumerWidget {
  final TodoFormViewModel viewModel;
  final Todo? todo;

  const DeleteTodoIconWidget({
    Key? key,
    required this.viewModel,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => viewModel.shouldShowDeleteTodoIcon()
          ? _showConfirmDeleteTodoDialog(context, ref)
          : {},
      child: Container(
        margin: EdgeInsets.all(Dim.width(context) / 25),
        child: Row(
          children: [
            SvgPicture.asset(
              S.appIcons.iconDelete,
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
                    : ColorApp.lightTheme.colorGrey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _showConfirmDeleteTodoDialog(BuildContext context, WidgetRef ref) async {
    final bool result = await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Text(AllLocale.of(context).deleteConfirm),
          actions: [
            TextButton(
              onPressed: () => ref.read(routerDelegateProvider).pop(false),
              child: Text(AllLocale.of(context).cancel.toUpperCase()),
            ),
            TextButton(
              onPressed: () => ref.read(routerDelegateProvider).pop(true),
              child: Text(AllLocale.of(context).delete.toUpperCase()),
            ),
          ],
        );
      },
    );
    if (result) {
      viewModel.deleteTodo();
      firebaseLogger(S.firebase.deleteLog, viewModel.initialTitleValue());
      ref.read(routerDelegateProvider).navigate([ListTodoSegment()]);
    }
  }
}
