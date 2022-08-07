import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimension.dart';
import '../../core/constants/strings.dart';
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
  late String dropdownvalue;
  int? datetime;

  final Map<String, dynamic> _availableImportanceColors = {
    "purple": ColorApp.lightTheme.colorSpecial,
    "red": ColorApp.lightTheme.colorRed,
  };

  final String _defaultImportanceColor = "red";
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> _initConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 1),
      minimumFetchInterval: const Duration(seconds: 10),
    ));

    _fetchConfig();
  }

  void _fetchConfig() async {
    await _remoteConfig.fetchAndActivate();
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.todo.text;
    datetime = widget.todo.deadline;
    _initConfig();
    _isSwitched = datetime != null ? true : false;
    dropdownvalue = widget.todo.importance;
  }


  void _toSetDeadline() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      setState(() {
        datetime = pickedDate.millisecondsSinceEpoch;
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  S.iconClose,
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    final message = _controller.text;
                    BlocProvider.of<EditTodoCubit>(context).updateTodo(
                        widget.todo,
                        message,
                        dropdownvalue,
                        datetime,
                        widget.revision);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15, top: 15),
                    child: Text(
                      AllLocale.of(context).save,
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              ],
            ),
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
                          contentPadding:
                              EdgeInsets.all(Dim.width(context) / 20),
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
                        SizedBox(
                          width: 110.0,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              child: DropdownButton(
                                value: dropdownvalue,
                                style: TextStyle(
                                    color: ColorApp.lightTheme.labelPrimary),
                                icon: const SizedBox.shrink(),
                                hint: Text(dropdownvalue),
                                items: [
                                  DropdownMenuItem(
                                    value: S.low,
                                    child: Text(AllLocale.of(context).low),
                                  ),
                                  DropdownMenuItem(
                                      value: S.basic,
                                      child: Text(AllLocale.of(context).basic)),
                                  DropdownMenuItem(
                                    value: S.important,
                                    child: Text(
                                      "!! ${AllLocale.of(context).important}",
                                      style: TextStyle(
                                          color: _availableImportanceColors[
                                              _remoteConfig
                                                      .getString(
                                                          'importanceColor')
                                                      .isNotEmpty
                                                  ? _remoteConfig.getString(
                                                      'importanceColor')
                                                  : _defaultImportanceColor]),
                                    ),
                                  )
                                ],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                                //style: Theme.of(context).textTheme.bodyText1,
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
                              datetime != null
                                  ? Text(
                                      DateFormat.yMMMMd('ru').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              datetime!)),
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context).textTheme.button)
                                  : const SizedBox.shrink()
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
                            S.iconDelete,
                            color: ColorApp.lightTheme.colorRed,
                          ),
                          SizedBox(
                            width: Dim.width(context) / 23,
                          ),
                          Text(
                            AllLocale.of(context).delete,
                            style:
                                TextStyle(color: ColorApp.lightTheme.colorRed),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
