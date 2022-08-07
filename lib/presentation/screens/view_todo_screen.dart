import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/core/localization/l10n/all_locales.dart';
import '../../data/models/todo/todo.dart';

class TodoViewScreen extends StatelessWidget {
  final Todo todo;

  const TodoViewScreen({Key? key, required this.todo}) : super(key: key);

  String _fromTsoFormatDate(int ts) {
    return DateFormat('dd MMMM yyy', 'ru')
        .format(DateTime.fromMillisecondsSinceEpoch(ts));
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(AllLocale.of(context).todoView),
      children: <Widget>[
        Center(
          child: Column(
              children:<Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                     border:TableBorder.all(width: 1.0,color: Colors.grey),
                    children: [
                      TableRow(
                          children: [
                            Text(AllLocale.of(context).task, textScaleFactor: 1.2,textAlign: TextAlign.center,),
                            Text(todo.text,textScaleFactor: 1.2,textAlign: TextAlign.center,),
                          ]
                      ),
                      TableRow(
                          children: [
                            Text(AllLocale.of(context).createdAt,textScaleFactor: 1.2,textAlign: TextAlign.center,),
                            Text(_fromTsoFormatDate(todo.createdAt),textScaleFactor: 1.2,textAlign: TextAlign.center,),
                          ]
                      ),
                      TableRow(
                          children: [
                            Text("${AllLocale.of(context).changedAt}",textScaleFactor:  1.2,textAlign: TextAlign.center,),
                            Text("${_fromTsoFormatDate(todo.changedAt)}",textScaleFactor:  1.2,textAlign: TextAlign.center,),
                          ]
                      ),
                      TableRow(
                          children: [
                            Text("${AllLocale.of(context).deadline}",textScaleFactor:  1.2,textAlign: TextAlign.center,),
                            Text("${todo.deadline == null
                                ? AllLocale.of(context).withoutDeadline
                                : _fromTsoFormatDate(todo.deadline!)}",textScaleFactor:  1.2,textAlign: TextAlign.center,),
                          ]
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(AllLocale.of(context).ok),
                      )
                    ],
                  ),
                ),
              ]
          ),
        )
      ],
    );
  }
}
