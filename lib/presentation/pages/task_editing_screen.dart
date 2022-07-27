import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/constants/colors.dart';
import 'package:todoapp/core/localization/l10n/all_locales.dart';

import '../../core/constants/dimension.dart';
import '../../core/navigation/controller.dart';
import '../../core/navigation/routes.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({Key? key}) : super(key: key);

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  bool isSwitched = false;
  final DateTime _selectedDate = DateTime.now();

  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

  String dropdownvalue = 'Нет';

  var items = [
    'Нет',
    'Низкий',
    '!!Высокий',
  ];

  void _toSetDeadline() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      String formattedDate = DateFormat.yMMMMd('ru').format(pickedDate);
      setState(() {
        dateInput.text = formattedDate;
      });
    } else {
      setState(() {
        isSwitched = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                AllLocale.of(context).incorrectDate),),);
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcfaf1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            leading: IconButton(
              onPressed: () {
                context.read<NavigationController>().pop();
              },
              icon: Icon(
                Icons.close,
                color: ColorApp.lightTheme.labelPrimary,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      AllLocale
                          .of(context)
                          .save,
                    ),
                  ))
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
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(Dim.width(context) / 20),
                        border: InputBorder.none,
                        hintText: AllLocale
                            .of(context)
                            .hintMessage),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(Dim.width(context) / 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AllLocale
                            .of(context)
                            .priority,
                        textAlign: TextAlign.left,
                      ),
                      DropdownButton(
                        value: dropdownvalue,
                        disabledHint: Text("Нет"),
                        elevation: 8,
                        isExpanded: true,
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
                        Text(
                          AllLocale
                              .of(context)
                              .completeDate,
                          textAlign: TextAlign.left,
                        ),

                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                            if (isSwitched) {
                              _toSetDeadline();
                            } else {
                              dateInput.clear();
                            }
                          },
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.all(Dim.width(context) / 25),
                  child: TextField(
                    controller: dateInput,
                    style: TextStyle(color: ColorApp.lightTheme.colorBlue),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    readOnly: true,
                  ),
                ),
                const Divider(
                  thickness: .8,
                ),
                Container(
                  margin: EdgeInsets.all(Dim.width(context) / 25),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: ColorApp.lightTheme.colorRed,
                        ),
                        SizedBox(
                          width: Dim.width(context) / 50,
                        ),
                        Text(
                          AllLocale
                              .of(context)
                              .delete,
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
      ),
    );
  }

}
