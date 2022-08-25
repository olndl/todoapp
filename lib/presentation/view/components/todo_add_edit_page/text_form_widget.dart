import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/dimension.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';

class TextFormWidget extends ConsumerWidget {
  final TodoFormViewModel viewModel;

  TextFormWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.all(Dim.width(context) / 25),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        initialValue: viewModel.initialTitleValue(),
        minLines: 4,
        maxLines: 100,
        autofocus: true,
        onChanged: (value) => viewModel.setTitle(value),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(Dim.width(context) / 20),
            border: InputBorder.none,
            hintText: AllLocale.of(context).hintMessage),
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.left,
      ),
    );
  }
}
