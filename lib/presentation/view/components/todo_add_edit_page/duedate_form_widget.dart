import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/dimension.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';
import '../../../viewmodel/todolist/toggle_calendar_viewmodel.dart';

class DueDateFormWidget extends ConsumerStatefulWidget {
  final TodoFormViewModel viewModel;

  const DueDateFormWidget(this.viewModel);

  @override
  DueDateFormWidgetState createState() => DueDateFormWidgetState();
}

class DueDateFormWidgetState extends ConsumerState<DueDateFormWidget> {
  String? _datetime;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var toggleController = ref.watch(toggleCalendarControllerProvider);
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
              _datetime != null
                  ? Text(
                      _datetime!,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.button,
                    )
                  : const SizedBox.shrink()
            ],
          ),
          Switch(
            value: toggleController,
            onChanged: (value) {
              ref
                  .read(toggleCalendarControllerProvider.notifier)
                  .toggleCalendar(value);
              if (value) {
                _toSetDeadline();
              } else {
                _datetime = null;
                widget.viewModel.setDueDate(null);
              }
            },
          )
        ],
      ),
    );
  }

  void _toSetDeadline() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      widget.viewModel.setDueDate(pickedDate.millisecondsSinceEpoch);
      setState(() {
        _datetime = DateFormat.yMMMMd(Platform.localeName).format(pickedDate);
      });
    } else {
      ref.read(toggleCalendarControllerProvider.notifier).toggleCalendar(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AllLocale.of(context).incorrectDate),
        ),
      );
    }
  }
}
