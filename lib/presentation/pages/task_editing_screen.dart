import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  String dropdownValue = 'One';
  final DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              icon: const Icon(Icons.close),
            ),
            actions: [
              TextButton(
                  onPressed: () {}, child: Text(AllLocale.of(context).save))
            ],
            flexibleSpace: const FlexibleSpaceBar(),
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
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(Dim.width(context) / 20),
                        border: InputBorder.none,
                        hintText: AllLocale.of(context).hintMessage),
                    textAlign: TextAlign.left,
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.all(Dim.width(context) / 25),
                //   child:  DropdownButton<String>(
                //     value: dropdownValue,
                //     icon: const Icon(Icons.arrow_downward),
                //     elevation: 16,
                //     style: const TextStyle(color: Colors.deepPurple),
                //     underline: Container(
                //       height: 2,
                //       color: Colors.deepPurpleAccent,
                //     ),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         dropdownValue = newValue!;
                //       });
                //     },
                //     items: <String>['One', 'Two', 'Free', 'Four']
                //         .map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //   ),
                // ),
                Container(
                    margin: EdgeInsets.all(Dim.width(context) / 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              AllLocale.of(context).completeDate,
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: Dim.height(context) / 40),
                            Text(
                              "${_selectedDate.toLocal()}".split(' ')[0],
                            ),
                            // Text(
                            //   _selectedDate ==
                            //           null //ternary expression to check if date is null
                            //       ? 'No date was chosen!'
                            //       : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                            //   textAlign: TextAlign.left,
                            // ),
                          ],
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                      ],
                    )),
                const Divider(
                  thickness: .8,
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(Icons.delete),
                        Text(AllLocale.of(context).delete)
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
