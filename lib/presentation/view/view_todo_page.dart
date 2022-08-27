import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/core/localization/l10n/all_locales.dart';

import '../../core/navigation/model.dart';
import '../../core/navigation/provider.dart';
import '../../domain/model/todo.dart';

class TodoViewScreen extends ConsumerWidget {
  final Todo todo;

  const TodoViewScreen({Key? key, required this.todo}) : super(key: key);

  String _fromTsoFormatDate(int ts) {
    return '${DateFormat.yMMMd(Platform.localeName).format(DateTime.fromMillisecondsSinceEpoch(ts))}\n${DateFormat.jms(Platform.localeName).format(DateTime.fromMillisecondsSinceEpoch(ts))}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SimpleDialog(
        title: Text(AllLocale.of(context).todoView),
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(23.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AllLocale.of(context).task,
                            textScaleFactor: 1.2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              todo.text,
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            AllLocale.of(context).createdAt,
                            textScaleFactor: 1.2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              _fromTsoFormatDate(todo.createdAt),
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            AllLocale.of(context).changedAt,
                            textScaleFactor: 1.2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              _fromTsoFormatDate(todo.changedAt),
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
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
                        onPressed: () => ref
                            .read(routerDelegateProvider)
                            .navigate([HomeSegment()]),
                        child: Text(AllLocale.of(context).ok),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
