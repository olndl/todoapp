import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/presentation/view/components/create_update_page_components/switch_off_icon_widget.dart';
import 'package:todoapp/presentation/view/components/create_update_page_components/switch_on_icon_widget.dart';
import '../../../../core/constants/dimension.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';

class DeadlineFormWidget extends ConsumerStatefulWidget {
  final TodoFormViewModel viewModel;

  const DeadlineFormWidget(this.viewModel);

  @override
  DeadlineFormWidgetState createState() => DeadlineFormWidgetState();
}

class DeadlineFormWidgetState extends ConsumerState<DeadlineFormWidget> {
  late TextEditingController _dueDateTextFieldController;

  @override
  void initState() {
    super.initState();
    _dueDateTextFieldController = TextEditingController(
      text: widget.viewModel.initialDueDateValue() != null
          ? DateFormat('dd MMMM yyyy').format(
              DateTime.fromMillisecondsSinceEpoch(
                  widget.viewModel.initialDueDateValue()!))
          : 'No',
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              widget.viewModel.initialDueDateValue() != null
                  ? Text(
                      DateFormat(S.dateFormat, 'ru').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          widget.viewModel.initialDueDateValue()!,
                        ),
                      ),
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.button,
                    )
                  : const SizedBox.shrink()
            ],
          ),
          widget.viewModel.shouldShowSwitchOn()
              ? SwitchOnIconWidget(viewModel: widget.viewModel)
              : SwitchOffIconWidget(viewModel: widget.viewModel),
        ],
      ),
    );
  }
}
