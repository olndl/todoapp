import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimension.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../../domain/model/todo.dart';
import '../../../viewmodel/todo_add_edit/importance_provider.dart';
import '../../../viewmodel/todo_add_edit/todo_add_edit_viewmodel.dart';

class ImportanceFormWidget extends ConsumerWidget {
  final Todo? _todo;
  final TodoFormViewModel viewModel;

  const ImportanceFormWidget(this.viewModel, this._todo, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = viewModel.initialImportanceValue();
    ref.watch(todoImportanceProvider(_todo)).todoCategory;
    return Container(
      margin: EdgeInsets.all(Dim.width(context) / 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AllLocale.of(context).priority,
            textAlign: TextAlign.left,
          ),
          SizedBox(
            width: 106,
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                child: DropdownButton(
                  value: category,
                  style: TextStyle(color: ColorApp.lightTheme.labelPrimary),
                  icon: const SizedBox.shrink(),
                  items: [
                    DropdownMenuItem(
                      value: S.api.low,
                      child: Text(
                        AllLocale.of(context).low,
                        style:
                            TextStyle(color: Theme.of(context).disabledColor),
                      ),
                      onTap: () => S.api.low,
                    ),
                    DropdownMenuItem(
                      value: S.api.basic,
                      child: Text(
                        AllLocale.of(context).basic,
                        style:
                            TextStyle(color: Theme.of(context).disabledColor),
                      ),
                      onTap: () => S.api.basic,
                    ),
                    DropdownMenuItem(
                      value: S.api.important,
                      child: Text(
                        '!! ${AllLocale.of(context).important}',
                        style: TextStyle(
                          color: ColorApp.lightTheme.colorRed,
                        ),
                      ),
                      onTap: () => S.api.important,
                    )
                  ],
                  onChanged: (String? newImportance) {
                    ref
                        .read(todoImportanceProvider(_todo))
                        .categoryOnChanged(newImportance!, _todo);
                    viewModel.setImportance(newImportance);
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: ColorApp.lightTheme.colorGrey,
          )
        ],
      ),
    );
  }
}
