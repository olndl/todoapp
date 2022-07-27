import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  bool isSwitched = false;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        pinned: true,
        snap: true,
        floating: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.close),
        ),
        actions: [TextButton(onPressed: () {}, child: Text('Сохранить'))],
        flexibleSpace: const FlexibleSpaceBar(),
      ),
      SliverToBoxAdapter(
          child: Column(
        children: [
          Card(
            child: TextField(
                minLines: 4,
                maxLines: 100,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none,
                    hintText: 'What need to do?'),
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: 'Roboto', fontSize: 16)),
            margin: const EdgeInsets.all(15),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(labelText: 'Важность'),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Сделать до',
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 20),
                      Text(
                        _selectedDate ==
                                null //ternary expression to check if date is null
                            ? 'No date was chosen!'
                            : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        _pickDateDialog();
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                ],
              )),
          Divider(
            thickness: .8,
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [Icon(Icons.delete), Text('Удалить')],
              ),
            ),
          )
        ],
      ))
    ]));
  }

  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }
}
