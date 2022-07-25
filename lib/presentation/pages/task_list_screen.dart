import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/localization/l10n/all_locales.dart';
import 'package:todoapp/presentation/widgets.dart';

import '../../core/constants/colors.dart';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AllLocale.of(context).tasks,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.size.width / 25),
          ),
          margin: EdgeInsets.only(
            top: widget.size.height / 40,
            left: widget.size.width / 56,
            right: widget.size.width / 56,
            bottom: widget.size.height / 40,
          ),
          child: Column(
            children: List<Widget>.generate(
              20,
              (i) => Todo(
                text: AllLocale.of(context).buySmth + ' $i',
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
