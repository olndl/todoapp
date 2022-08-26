import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimension.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../../domain/model/todo.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';
import '../../../viewmodel/todolist/importance_provider.dart';

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
                        value: S.low,
                        child: Text(AllLocale.of(context).low, style: TextStyle(color: Theme.of(context).disabledColor),),
                        onTap: () => S.low,
                      ),
                      DropdownMenuItem(
                        value: S.basic,
                        child: Text(AllLocale.of(context).basic, style: TextStyle(color: Theme.of(context).disabledColor),),
                        onTap: () => S.basic,
                      ),
                      DropdownMenuItem(
                        value: S.important,
                        child: Text(
                          '!! ${AllLocale.of(context).important}',
                          style: TextStyle(
                            color: ColorApp.lightTheme.colorRed,
                          ),
                        ),
                        onTap: () => S.important,
                      )
                    ],
                    onChanged: (String? newImportance) {
                      ref
                          .read(todoImportanceProvider(_todo))
                          .categoryOnChanged(newImportance!, _todo);
                      viewModel.setImportance(newImportance);
                    },),
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
