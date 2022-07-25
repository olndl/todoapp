import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/localization/l10n/all_locales.dart';

import '../../core/colors/colors.dart';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({Key? key}) : super(key: key);

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Мои дела',
          style: TextStyle(color: ColorApp.labelPrimary),
        ),
        backgroundColor: ColorApp.backPrimary,
      ),
      backgroundColor: ColorApp.backPrimary,
      body: SingleChildScrollView(
        child: Card(
          color: ColorApp.backSecondary,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.only(top: 20, left: 7, right: 7),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      setState(() {});
                    }),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.info_outline),
                ),
                title: Text(
                  'Купить что-то',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

}
