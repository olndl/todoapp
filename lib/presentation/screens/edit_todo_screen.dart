import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/todo/todo.dart';
import '../bloc/edit_todo/edit_todo_cubit.dart';


class EditTodoScreen extends StatefulWidget {
  final Todo todo;
  final int revision;

  const EditTodoScreen({Key? key, required this.todo, required this.revision}) : super(key: key);

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.todo.text;

    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        if (state is TodoEdited) {
          Navigator.pop(context);
        } else if (state is EditTodoError) {
          print(state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Todo"),
          actions: [
            InkWell(
              onTap: () {
                BlocProvider.of<EditTodoCubit>(context)
                    .deleteTodo(widget.todo, widget.revision);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.delete),
              ),
            )
          ],
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            autocorrect: true,
            decoration: InputDecoration(hintText: "Enter todo message..."),
          ),
          SizedBox(height: 10.0),
          InkWell(
              onTap: () {
                BlocProvider.of<EditTodoCubit>(context)
                    .updateTodo(widget.todo, _controller.text, widget.revision);
              },
              child: _updateBtn(context))
        ],
      ),
    );
  }

  Widget _updateBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          "Update Todo",
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:todoapp/core/constants/colors.dart';
// import 'package:todoapp/core/localization/l10n/all_locales.dart';
//
// import '../../core/constants/dimension.dart';
// import '../../core/navigation/controller.dart';
// import '../../data/models/todo/todo.dart';
//
// class TaskDetailsScreen extends StatefulWidget {
//   final Todo todo;
//   final int revision;
//   const TaskDetailsScreen({Key? key, required this.todo, required this.revision}) : super(key: key);
//
//   @override
//   State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
// }
//
// class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
//   bool isSwitched = false;
//
//   TextEditingController dateInput = TextEditingController();
//
//   @override
//   void initState() {
//     dateInput.text = "";
//     super.initState();
//   }
//
//   String dropdownvalue = 'Нет';
//
//   var items = [
//     'Нет',
//     'Низкий',
//     '!!Высокий',
//   ];
//
//   void _toSetDeadline() async {
//     DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime.now(),
//         lastDate: DateTime(2101));
//     if (pickedDate != null) {
//       String formattedDate = DateFormat.yMMMMd('ru').format(pickedDate);
//       setState(() {
//         dateInput.text = formattedDate;
//       });
//     } else {
//       setState(() {
//         isSwitched = false;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 AllLocale.of(context).incorrectDate),),);
//       }
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfffcfaf1),
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             pinned: true,
//             snap: true,
//             floating: true,
//             leading: IconButton(
//               onPressed: () {
//                 context.read<NavigationController>().pop();
//               },
//               icon: Icon(
//                 Icons.close,
//                 color: ColorApp.lightTheme.labelPrimary,
//               ),
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () {},
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: Text(
//                       AllLocale
//                           .of(context)
//                           .save,
//                     ),
//                   ))
//             ],
//           ),
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 Card(
//                   color: Colors.white,
//                   margin: EdgeInsets.all(Dim.width(context) / 25),
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: TextField(
//                     minLines: 4,
//                     maxLines: 100,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(Dim.width(context) / 20),
//                         border: InputBorder.none,
//                         hintText: AllLocale
//                             .of(context)
//                             .hintMessage),
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.all(Dim.width(context) / 25),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         AllLocale
//                             .of(context)
//                             .priority,
//                         textAlign: TextAlign.left,
//                       ),
//                       DropdownButton(
//                         value: dropdownvalue,
//                         disabledHint: Text("Нет"),
//                         elevation: 8,
//                         isExpanded: true,
//                         underline: Divider(),
//                         items: items.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(items),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             dropdownvalue = newValue!;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                     margin: EdgeInsets.all(Dim.width(context) / 25),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               AllLocale
//                                   .of(context)
//                                   .completeDate,
//                               textAlign: TextAlign.left,
//                             ),
//                             Text(dateInput.text,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(color: ColorApp.lightTheme.colorBlue,
//                               fontSize: 14),)
//                           ],
//                         ),
//                         Switch(
//                           value: isSwitched,
//                           onChanged: (value) {
//                             setState(() {
//                               isSwitched = value;
//                             });
//                             if (isSwitched) {
//                               _toSetDeadline();
//                             } else {
//                               dateInput.clear();
//                             }
//                           },
//                         ),
//                       ],
//                     )),
//                 const Divider(
//                   thickness: .8,
//                 ),
//                 Container(
//                   margin: EdgeInsets.all(Dim.width(context) / 25),
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.delete,
//                           color: ColorApp.lightTheme.colorRed,
//                         ),
//                         SizedBox(
//                           width: Dim.width(context) / 50,
//                         ),
//                         Text(
//                           AllLocale
//                               .of(context)
//                               .delete,
//                           style: TextStyle(color: ColorApp.lightTheme.colorRed),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }
