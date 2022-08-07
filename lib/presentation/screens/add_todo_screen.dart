import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimension.dart';
import '../../core/constants/strings.dart';
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
  final Uuid uuid = const Uuid();

  final _controller = TextEditingController();
  bool _isSwitched = false;
  int? _datetime;

  String dropdownValue = S.low;


  final Map<String, dynamic> _availableImportanceColors = {
    "purple": ColorApp.lightTheme.colorSpecial,
    "red": ColorApp.lightTheme.colorRed,
  };


  final String _defaultImportanceColor = "red";
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> _initConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(
          seconds: 1),
      minimumFetchInterval: const Duration(
          seconds:
          10),
    ));

    _fetchConfig();
  }


  void _fetchConfig() async {
    await _remoteConfig.fetchAndActivate();
  }

  @override
  void initState() {
    super.initState();
    _initConfig();
  }

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
                  'assets/icons/close.svg',
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    final message = _controller.text;
                    Todo newTask = Todo(
                        id: uuid.v4(),
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                        text: message,
                        lastUpdatedBy: "olndlDevice",
                        changedAt: DateTime.now().millisecondsSinceEpoch,
                        deadline: _datetime,
                        done: false,
                        importance: dropdownValue);
                    BlocProvider.of<AddTodoCubit>(context)
                        .addTodo(newTask, widget.revision);
                  },
                  child: BlocBuilder<AddTodoCubit, AddTodoState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15, top: 15),
                        child: Text(
                          AllLocale.of(context).save,
                          style: Theme.of(context).textTheme.button,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Card(
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
                          contentPadding:
                              EdgeInsets.all(Dim.width(context) / 20),
                          border: InputBorder.none,
                          hintText: AllLocale.of(context).hintMessage),
                      style: Theme.of(context).textTheme.bodyText1,
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
                        Container(
                          width: 106,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              child: DropdownButton(
                                value: dropdownValue,
                                style: TextStyle(
                                    color: ColorApp.lightTheme.labelPrimary),
                                icon: const SizedBox.shrink(),
                                hint: Text(dropdownValue),
                                items: [
                                  //add items in the dropdown
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
                                          _remoteConfig.getString('importanceColor').isNotEmpty
                                              ? _remoteConfig.getString('importanceColor')
                                              : _defaultImportanceColor]),
                                    ),
                                  )
                                ],
                                onChanged: (String? newValue) {
                                  setState(
                                    () {
                                      dropdownValue = newValue!;
                                    },
                                  );
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
                              _datetime != null
                                  ? Text(
                                      DateFormat.yMMMMd('ru').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              _datetime!)),
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
                            style:
                                TextStyle(color: ColorApp.lightTheme.colorGrey),
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
