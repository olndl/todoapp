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
                      hint: Text("Важность"),
                      isExpanded: true,
                      icon: const SizedBox.shrink(),
                      elevation: 16,
                      style: const TextStyle(color: Colors.grey),
                      underline: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
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
                  onTap: () {
                    BlocProvider.of<EditTodoCubit>(context)
                        .deleteTodo(widget.todo, widget.revision);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/delete.svg',
                        color: ColorApp.lightTheme.colorRed,
                      ),
                      SizedBox(
                        width: Dim.width(context) / 50,
                      ),
                      Text(
                        AllLocale.of(context).delete,
                        style: TextStyle(color: ColorApp.lightTheme.colorRed),
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
        icon: SvgPicture.asset(
          'assets/icons/close.svg',
          color: ColorApp.lightTheme.labelPrimary,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            final message = _controller.text;
            BlocProvider.of<EditTodoCubit>(context).updateTodo(
                widget.todo, message, dropdownvalue, datetime, widget.revision);
          },
          child: _addBtn(context),
        ),
      ],
    );
  }

  Widget _addBtn(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        AllLocale.of(context).save,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
