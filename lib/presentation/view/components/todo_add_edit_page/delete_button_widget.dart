import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimension.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../../core/navigation/model.dart';
import '../../../../core/navigation/provider.dart';
import '../../../viewmodel/todo_add_edit/todo_add_edit_viewmodel.dart';

class DeleteTodoIconWidget extends ConsumerWidget {
  final TodoFormViewModel viewModel;

  const DeleteTodoIconWidget({Key? key, required this.viewModel})
      : super(key: key);

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
                      : ColorApp.lightTheme.colorGrey,),
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
      ref.read(routerDelegateProvider).navigate([HomeSegment()]);
    }
  }
}
