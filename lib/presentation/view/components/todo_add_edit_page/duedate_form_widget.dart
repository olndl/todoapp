import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/dimension.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../../domain/model/todo.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';
import '../../../viewmodel/todolist/switcher_provider.dart';

class DueDateFormWidget extends ConsumerWidget {
  final Todo? todo;
  final TodoFormViewModel viewModel;

  const DueDateFormWidget(this.viewModel, this.todo, {Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toSwitch = ref.watch(switcherProvider(todo));
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
              todo?.deadline != null
                  ? Text(
                      DateFormat.yMMMMd(Platform.localeName).format(
                        DateTime.fromMillisecondsSinceEpoch(
                          todo?.deadline ?? 0,
                        ),
                      ),
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.button,
                    )
                  : const SizedBox.shrink()
            ],
          ),
          Switch(
            value: toSwitch,
            onChanged: (value) {
              ref.read(switcherProvider(todo).notifier).toggleCalendar(value);
              if (value) {
                toSetDeadline(context, ref);
              } else {
                viewModel.setDueDate(null);
              }
            },
          )
        ],
      ),
    );
  }

  Future<void> toSetDeadline(BuildContext context, WidgetRef ref) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2222),
    );
    if (pickedDate != null) {
      viewModel.setDueDate(pickedDate.millisecondsSinceEpoch);
    } else {
      ref.read(switcherProvider(todo).notifier).toggleCalendar(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AllLocale.of(context).incorrectDate),
        ),
      );
    }
  }
}