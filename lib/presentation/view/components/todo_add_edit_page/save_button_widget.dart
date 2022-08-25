import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';

class SaveButtonWidget extends ConsumerWidget {
  final TodoFormViewModel viewModel;

  SaveButtonWidget({required this.viewModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final currentTitle = viewModel.initialTitleValue();
          if (currentTitle != '') {
            viewModel.createOrUpdateTodo();
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AllLocale.of(context).incorrectDate),
              ),
            );
          }
        },
        child: Text(AllLocale.of(context).save),
      ),
    );
  }
}
