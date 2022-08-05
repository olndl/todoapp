import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimension.dart';
import '../../core/localization/l10n/all_locales.dart';
import '../../data/models/todo/todo.dart';
import '../bloc/edit_todo/edit_todo_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo todo;
  final int revision;

  const EditTodoScreen({Key? key, required this.todo, required this.revision})
      : super(key: key);

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _controller = TextEditingController();
  late bool _isSwitched;
  int? datetime;

  @override
  void initState() {
    _controller.text = widget.todo.text;
    datetime = widget.todo.deadline;
    _isSwitched = datetime != null ? true : false;
    super.initState();
  }

  String dropdownvalue = 'low';

  var items = [
    'low',
    'basic',
    'important',
  ];

  void _toSetDeadline() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      setState(() {
        datetime = pickedDate.millisecondsSinceEpoch;
        //dateInput.text = formattedDate;
      });
    } else {
      setState(() {
        _isSwitched = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AllLocale.of(context).incorrectDate),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        if (state is TodoEdited) {
          Navigator.pop(context);
        } else if (state is EditTodoError) {
          print(state.error);
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
                  autocorrect: true,
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(Dim.width(context) / 20),
                      border: InputBorder.none,
                      hintText: AllLocale.of(context).hintMessage),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.all(Dim.width(context) / 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AllLocale.of(context).priority,
                      textAlign: TextAlign.left,
                    ),
                    DropdownButton(
                      value: dropdownvalue,
                      disabledHint: Text(dropdownvalue),
                      elevation: 8,
                      isExpanded: true,
                      underline: Divider(),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
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
                          Text(
                            datetime == null
                                ? ""
                                : DateFormat.yMMMMd('ru').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        datetime!)),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: ColorApp.lightTheme.colorBlue,
                                fontSize: 14),
                          )
                        ],
                      ),
                      Switch(
                        value: _isSwitched,
                        onChanged: (value) {
                          setState(() {
                            _isSwitched = value;
                          });
                          if (_isSwitched) {
                            _toSetDeadline();
                          } else {
                            datetime = null;
                          }
                        },
                      ),
                    ],
                  )),
              const Divider(
                thickness: .8,
              ),
              Container(
                margin: EdgeInsets.all(Dim.width(context) / 25),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/delete.svg',
                        color:  ColorApp.lightTheme.colorRed,
                      ),
                      SizedBox(
                        width: Dim.width(context) / 50,
                      ),
                      Text(
                        AllLocale.of(context).delete,
                        style: TextStyle(color: ColorApp.lightTheme.colorGrey),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
        icon:  SvgPicture.asset(
          'assets/icons/close.svg',
          color:  ColorApp.lightTheme.labelPrimary,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            final message = _controller.text;
            BlocProvider.of<EditTodoCubit>(context)
                    .updateTodo(widget.todo, message, dropdownvalue,
                datetime, widget.revision);
          },
          child: _addBtn(context),
        ),
      ],
    );
  }

  Widget _addBtn(context) {
  return Padding(
          padding: const EdgeInsets.only(right: 8, top: 10, bottom: 5),
          child: Text(
            AllLocale.of(context).save,
            style: TextStyle(color: Colors.blue),
          ),
        );
  }
}







//   final _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     _controller.text = widget.todo.text;

//     return BlocListener<EditTodoCubit, EditTodoState>(
//       listener: (context, state) {
//         if (state is TodoEdited) {
//           Navigator.pop(context);
//         } else if (state is EditTodoError) {
//           print(state.error);
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Edit Todo"),
//           actions: [
//             InkWell(
//               onTap: () {
//                 BlocProvider.of<EditTodoCubit>(context)
//                     .deleteTodo(widget.todo, widget.revision);
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Icon(Icons.delete),
//               ),
//             )
//           ],
//         ),
//         body: _body(context),
//       ),
//     );
//   }

//   Widget _body(context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         children: [
//           TextField(
//             controller: _controller,
//             autocorrect: true,
//             decoration: InputDecoration(hintText: "Enter todo message..."),
//           ),
//           SizedBox(height: 10.0),
//           InkWell(
//               onTap: () {
//                 BlocProvider.of<EditTodoCubit>(context)
//                     .updateTodo(widget.todo, _controller.text, widget.revision);
//               },
//               child: _updateBtn(context))
//         ],
//       ),
//     );
//   }

//   Widget _updateBtn(context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 50.0,
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Center(
//         child: Text(
//           "Update Todo",
//           style: TextStyle(fontSize: 15.0, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import '../../core/constants/colors.dart';
// import '../../core/constants/dimension.dart';
// import '../../core/localization/l10n/all_locales.dart';
// import '../../data/models/todo/todo.dart';
// import '../bloc/add_todo/add_todo_cubit.dart';

// class AddTodoScreen extends StatefulWidget {
//   final int revision;

//   const AddTodoScreen({Key? key, required this.revision}) : super(key: key);

//   @override
//   State<AddTodoScreen> createState() => _AddTodoScreenState();
// }

// class _AddTodoScreenState extends State<AddTodoScreen> {
//   Random _random = Random();
//   final _controller = TextEditingController();

//   bool isSwitched = false;
//   int? datetime;

//   //TextEditingController dateInput = TextEditingController();

//   @override
//   void initState() {
//     //dateInput.text = "";
//     int datetime = 0;
//     super.initState();
//   }

//   String dropdownvalue = 'low';

//   var items = [
//     'low',
//     'basic',
//     'important',
//   ];

//   void _toSetDeadline() async {
//     DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime.now(),
//         lastDate: DateTime(2101));
//     if (pickedDate != null) {
//       setState(() {
//         datetime = pickedDate.millisecondsSinceEpoch;
//         //dateInput.text = formattedDate;
//       });
//     } else {
//       setState(() {
//         isSwitched = false;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(AllLocale.of(context).incorrectDate),
//           ),
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AddTodoCubit, AddTodoState>(
//       listener: (context, state) {
//         if (state is TodoAdded) {
//           Navigator.pop(context);
//         } else if (state is AddTodoError) {
//           debugPrint(state.error);
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Color(0xfffcfaf1),
//         body: _addBody(),
//       ),
//     );
//   }

//   Widget _addBody() {
//     return CustomScrollView(
//       slivers: [
//         _appBar(),
//         SliverToBoxAdapter(
//           child: Column(
//             children: [
//               Card(
//                 color: Colors.white,
//                 margin: EdgeInsets.all(Dim.width(context) / 25),
//                 shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 child: TextField(
//                   minLines: 4,
//                   maxLines: 100,
//                   autofocus: true,
//                   controller: _controller,
//                   keyboardType: TextInputType.text,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(Dim.width(context) / 20),
//                       border: InputBorder.none,
//                       hintText: AllLocale.of(context).hintMessage),
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.all(Dim.width(context) / 25),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       AllLocale.of(context).priority,
//                       textAlign: TextAlign.left,
//                     ),
//                     DropdownButton(
//                       value: dropdownvalue,
//                       disabledHint: Text(dropdownvalue),
//                       elevation: 8,
//                       isExpanded: true,
//                       underline: Divider(),
//                       items: items.map((String items) {
//                         return DropdownMenuItem(
//                           value: items,
//                           child: Text(items),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           dropdownvalue = newValue!;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                   margin: EdgeInsets.all(Dim.width(context) / 25),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             AllLocale.of(context).completeDate,
//                             textAlign: TextAlign.left,
//                           ),
//                           Text(
//                             datetime == null
//                                 ? ""
//                                 : DateFormat.yMMMMd('ru').format(
//                                     DateTime.fromMillisecondsSinceEpoch(
//                                         datetime!)),
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 color: ColorApp.lightTheme.colorBlue,
//                                 fontSize: 14),
//                           )
//                         ],
//                       ),
//                       Switch(
//                         value: isSwitched,
//                         onChanged: (value) {
//                           setState(() {
//                             isSwitched = value;
//                           });
//                           if (isSwitched) {
//                             _toSetDeadline();
//                           } else {
//                             datetime = 0;
//                             //dateInput.clear();
//                           }
//                         },
//                       ),
//                     ],
//                   )),
//               const Divider(
//                 thickness: .8,
//               ),
//               Container(
//                 margin: EdgeInsets.all(Dim.width(context) / 25),
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.delete,
//                         color: ColorApp.lightTheme.colorGrey,
//                       ),
//                       SizedBox(
//                         width: Dim.width(context) / 50,
//                       ),
//                       Text(
//                         AllLocale.of(context).delete,
//                         style: TextStyle(color: ColorApp.lightTheme.colorGrey),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _appBar() {
//     return SliverAppBar(
//       backgroundColor: Color(0xfffcfaf1),
//       pinned: true,
//       snap: true,
//       floating: true,
//       leading: IconButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         icon: Icon(
//           Icons.close,
//           color: ColorApp.lightTheme.labelPrimary,
//         ),
//       ),
//       actions: [
//         InkWell(
//           onTap: () {
//             final message = _controller.text;
//             Todo newTask = Todo(
//                 id: _random.nextInt(10000).toString(),
//                 createdAt: DateTime.now().millisecondsSinceEpoch,
//                 text: message,
//                 lastUpdatedBy: "123",
//                 changedAt: DateTime.now().millisecondsSinceEpoch,
//                 deadline: datetime,
//                 done: false,
//                 importance: dropdownvalue);
//             BlocProvider.of<AddTodoCubit>(context)
//                 .addTodo(newTask, widget.revision);
//           },
//           child: _addBtn(context),
//         ),
//       ],
//     );
//   }

//   Widget _addBtn(context) {
//     return BlocBuilder<AddTodoCubit, AddTodoState>(
//       builder: (context, state) {
//         return Padding(
//           padding: const EdgeInsets.only(right: 8, top: 10, bottom: 5),
//           child: Text(
//             AllLocale.of(context).save,
//             style: TextStyle(color: Colors.blue),
//           ),
//         );
//       },
//     );
//   }
// }






















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
