import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimension.dart';
import '../../core/localization/l10n/all_locales.dart';
import '../../data/models/todo/todo.dart';
import '../bloc/add_todo/add_todo_cubit.dart';

class AddTodoScreen extends StatefulWidget {
  final int revision;

  const AddTodoScreen({Key? key, required this.revision}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  Random _random = Random();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTodoCubit, AddTodoState>(
      listener: (context, state) {
        if (state is TodoAdded) {
          Navigator.pop(context);
        } else if (state is AddTodoError) {
          debugPrint(state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xfffcfaf1),
        body: _addBody(),
      ),
    );
  }

  Widget _addBody() {
    return CustomScrollView(
      slivers: [
        _appBar(),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(Dim.width(context) / 25),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  minLines: 4,
                  maxLines: 100,
                  autofocus: true,
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(Dim.width(context) / 20),
                      border: InputBorder.none,
                      hintText: AllLocale.of(context).hintMessage),
                  textAlign: TextAlign.left,
                ),
              ),
          //     Container(
          //       margin: EdgeInsets.all(Dim.width(context) / 25),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             AllLocale.of(context).priority,
          //             textAlign: TextAlign.left,
          //           ),
          //           DropdownButton(
          //             value: dropdownvalue,
          //             disabledHint: Text("Нет"),
          //             elevation: 8,
          //             isExpanded: true,
          //             underline: Divider(),
          //             items: items.map((String items) {
          //               return DropdownMenuItem(
          //                 value: items,
          //                 child: Text(items),
          //               );
          //             }).toList(),
          //             onChanged: (String? newValue) {
          //               setState(() {
          //                 dropdownvalue = newValue!;
          //               });
          //             },
          //           ),
          //         ],
          //       ),
          //     ),
          //     Container(
          //         margin: EdgeInsets.all(Dim.width(context) / 25),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   AllLocale.of(context).completeDate,
          //                   textAlign: TextAlign.left,
          //                 ),
          //                 Text(
          //                   dateInput.text,
          //                   textAlign: TextAlign.left,
          //                   style: TextStyle(
          //                       color: ColorApp.lightTheme.colorBlue,
          //                       fontSize: 14),
          //                 )
          //               ],
          //             ),
          //             Switch(
          //               value: isSwitched,
          //               onChanged: (value) {
          //                 setState(() {
          //                   isSwitched = value;
          //                 });
          //                 if (isSwitched) {
          //                   _toSetDeadline();
          //                 } else {
          //                   dateInput.clear();
          //                 }
          //               },
          //             ),
          //           ],
          //         )),
          //     const Divider(
          //       thickness: .8,
          //     ),
          //     Container(
          //       margin: EdgeInsets.all(Dim.width(context) / 25),
          //       child: GestureDetector(
          //         onTap: () {},
          //         child: Row(
          //           children: [
          //             Icon(
          //               Icons.delete,
          //               color: ColorApp.lightTheme.colorRed,
          //             ),
          //             SizedBox(
          //               width: Dim.width(context) / 50,
          //             ),
          //             Text(
          //               AllLocale.of(context).delete,
          //               style: TextStyle(color: ColorApp.lightTheme.colorRed),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],)
    )
      ],
    );
  }

  Widget _appBar() {
    return SliverAppBar(
      backgroundColor: Color(0xfffcfaf1),
      pinned: true,
      snap: true,
      floating: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.close,
          color: ColorApp.lightTheme.labelPrimary,
        ),
      ),
      actions: [
        InkWell(
                  onTap: () {
                    final message = _controller.text;
                    Todo newTask = Todo(
                        id: _random.nextInt(10000).toString(),
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                        text: message,
                        lastUpdatedBy: "123",
                        changedAt: DateTime.now().millisecondsSinceEpoch,
                        deadline: DateTime.now().millisecondsSinceEpoch,
                        done: false,
                        importance: 'low');
                    BlocProvider.of<AddTodoCubit>(context)
                        .addTodo(newTask, widget.revision);
                  },
                  child: _addBtn(context),
                ),
      ],
    );
  }

  Widget _addBtn(context) {
    return BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            //if (state is AddingTodo) return CircularProgressIndicator();
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                AllLocale.of(context).save, style: TextStyle(color: Colors.blue),
              ),
            );
          },
        );
  }

  Widget _body(context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          margin: EdgeInsets.all(Dim.width(context) / 25),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextField(
            minLines: 4,
            maxLines: 100,
            autofocus: true,
            controller: _controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(Dim.width(context) / 20),
                border: InputBorder.none,
                hintText: AllLocale.of(context).hintMessage),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 10.0),
        InkWell(
          onTap: () {
            final message = _controller.text;
            Todo newTask = Todo(
                id: _random.nextInt(10000).toString(),
                createdAt: DateTime.now().millisecondsSinceEpoch,
                text: message,
                lastUpdatedBy: "123",
                changedAt: DateTime.now().millisecondsSinceEpoch,
                deadline: DateTime.now().millisecondsSinceEpoch,
                done: false,
                importance: 'low');
            BlocProvider.of<AddTodoCubit>(context)
                .addTodo(newTask, widget.revision);
          },
          child: _addBtn(context),
        )
      ],
    );
  }
}

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
