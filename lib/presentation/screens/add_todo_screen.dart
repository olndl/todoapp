import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimension.dart';
import '../../core/errors/logger.dart';
import '../../core/localization/l10n/all_locales.dart';
import '../../data/models/todo/todo.dart';
import '../bloc/add_todo/add_todo_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddTodoScreen extends StatefulWidget {
  final int revision;

  const AddTodoScreen({Key? key, required this.revision}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  Uuid uuid = const Uuid();

  final _controller = TextEditingController();
  bool _isSwitched = false;
  int? _datetime;

  String dropdownValue = 'low';

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
        _datetime = pickedDate.millisecondsSinceEpoch;
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
    return BlocListener<AddTodoCubit, AddTodoState>(
      listener: (context, state) {
        if (state is TodoAdded) {
          Navigator.pop(context);
        } else if (state is AddTodoError) {
          logger.info(
            'Error: - ${state.error}',
          );
      ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: - ${state.error}'),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xfffcfaf1),
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
                      value: dropdownValue,
                      hint: Text("Важность"),
                      isExpanded: true,
                      icon: const SizedBox.shrink(),
                      elevation: 16,
                      style: const TextStyle(color: Colors.grey),
                      underline: Container(
                        height: 1,
                        color: Colors.grey[350],
                      ),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
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
                            _datetime == null
                                ? ""
                                : DateFormat.yMMMMd('ru').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        _datetime!)),
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
                            _datetime = null;
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
                        color: ColorApp.lightTheme.colorGrey,
                      ),
                      SizedBox(
                        width: Dim.width(context) / 23,
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
        icon:
        SvgPicture.asset(
          'assets/icons/close.svg',
          color:  ColorApp.lightTheme.labelPrimary,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            final message = _controller.text;
            Todo newTask = Todo(
                id: uuid.v4().toString(),
                createdAt: DateTime.now().millisecondsSinceEpoch,
                text: message,
                lastUpdatedBy: "123",
                changedAt: DateTime.now().millisecondsSinceEpoch,
                deadline: _datetime,
                done: false,
                importance: dropdownValue);
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
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
              AllLocale.of(context).save,
              style: const TextStyle(color: Colors.blue),
            ),
        );

      },
    );
  }
}
