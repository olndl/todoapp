import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimension.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../../domain/model/todo.dart';
import '../../../viewmodel/todoform/todo_add_edit_viewmodel.dart';



class ImportanceFormWidget extends ConsumerStatefulWidget {
  final Todo? todo;

  const ImportanceFormWidget({Key? key, required this.todo}) : super(key: key);

  @override
  ImportanceFormWidgetState createState() => ImportanceFormWidgetState();
}

class ImportanceFormWidgetState extends ConsumerState<ImportanceFormWidget> {
  late final TodoFormViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(todoFormViewModelProvider(widget.todo));
  }


  @override
  Widget build(BuildContext context) {
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
                  value: _viewModel.initialImportanceValue(),
                  onChanged: (String? newImportance) =>
                      _viewModel.setImportance(newImportance!),
                  style: TextStyle(color: ColorApp.lightTheme.labelPrimary),
                  icon: const SizedBox.shrink(),
                  items: [
                    DropdownMenuItem(
                      value: S.low,
                      child: Text(AllLocale.of(context).low),
                    ),
                    DropdownMenuItem(
                      value: S.basic,
                      child: Text(AllLocale.of(context).basic),
                    ),
                    DropdownMenuItem(
                      value: S.important,
                      child: Text(
                        '!! ${AllLocale.of(context).important}',
                        style: TextStyle(
                          color: ColorApp.lightTheme.colorRed,
                        ),
                      ),
                    )
                  ],
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

//
// class ImportanceFormWidget extends StatelessWidget {
//   final TodoFormViewModel viewModel;
//
//   ImportanceFormWidget({Key? key, required this.viewModel}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(Dim.width(context) / 25),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             AllLocale.of(context).priority,
//             textAlign: TextAlign.left,
//           ),
//           SizedBox(
//             width: 106,
//             child: DropdownButtonHideUnderline(
//               child: ButtonTheme(
//                 child: DropdownButton(
//                   value: viewModel.initialImportanceValue(),
//                   onChanged: (String? newImportance) =>
//                       viewModel.setImportance(newImportance!),
//                   style: TextStyle(color: ColorApp.lightTheme.labelPrimary),
//                   icon: const SizedBox.shrink(),
//                   items: [
//                     DropdownMenuItem(
//                       value: S.low,
//                       child: Text(AllLocale.of(context).low),
//                     ),
//                     DropdownMenuItem(
//                       value: S.basic,
//                       child: Text(AllLocale.of(context).basic),
//                     ),
//                     DropdownMenuItem(
//                       value: S.important,
//                       child: Text(
//                         '!! ${AllLocale.of(context).important}',
//                         style: TextStyle(
//                           color: ColorApp.lightTheme.colorRed,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             height: 1,
//             color: ColorApp.lightTheme.colorGrey,
//           )
//         ],
//       ),
//     );
//   }
// }
