import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/constants/dimension.dart';
import 'package:todoapp/core/localization/l10n/all_locales.dart';

import '../../core/constants/colors.dart';
import '../../core/navigation/controller.dart';
import '../../data/models/task_model.dart';

class TaskViewScreen extends StatefulWidget {
  const TaskViewScreen({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<TaskViewScreen> createState() => _TaskViewScreenState();
}

class _TaskViewScreenState extends State<TaskViewScreen> {
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scaffold(
      backgroundColor: Color(0xfffcfaf1),
      body: CustomScrollView(slivers: [
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
        ),
        SliverToBoxAdapter(child: _buildCard(context, widget.task)),
      ]),
    );
  }

  Widget _buildCard(BuildContext context, Task task) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          margin: EdgeInsets.all(Dim.width(context) / 25),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextField(
            minLines: 4,
            maxLines: 100,
            readOnly: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(Dim.width(context) / 20),
                border: InputBorder.none,
                hintText: task.text),
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
              TextField(
                minLines: 1,
                maxLines: 1,
                readOnly: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(Dim.width(context) / 20),
                    hintText: task.importance),
                textAlign: TextAlign.left,
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
                  AllLocale.of(context).completeDate,
                  textAlign: TextAlign.left,
                ),
              ],
            )),
        Container(
          margin: EdgeInsets.all(Dim.width(context) / 25),
          child: TextField(
            style: TextStyle(color: ColorApp.lightTheme.colorBlue),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.task.deadline != null
                    ? DateFormat('dd MMMM yyy', 'ru').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.task.deadline! * 1000))
                    : 'Нет'),
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
                  AllLocale.of(context).delete,
                  style: TextStyle(color: ColorApp.lightTheme.colorRed),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
