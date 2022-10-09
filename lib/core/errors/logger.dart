import 'dart:developer' as dev;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../constants/strings.dart';

final logger = Logger('');

const deleteLog = 'delete_todo';
const addLog = 'add_todo';
const completeLog = 'complete_todo';

void initLogger() {
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((log) {
      dev.log(
        log.message,
        time: log.time,
        sequenceNumber: log.sequenceNumber,
        level: log.level.value,
        name: log.loggerName,
        zone: log.zone,
        error: log.error,
        stackTrace: log.stackTrace,
      );
    });
  }
}

void firebaseLogger(String event, String title) {
  switch (event) {
    case addLog:
      FirebaseAnalytics.instance
          .logEvent(name: S.firebase.addLog, parameters: {'full_text': title});
      break;
    case deleteLog:
      FirebaseAnalytics.instance.logEvent(
        name: S.firebase.deleteLog,
        parameters: {'full_text': title},
      );
      break;
    case completeLog:
      FirebaseAnalytics.instance.logEvent(
        name: S.firebase.completeLog,
        parameters: {'full_text': title},
      );
      break;
  }
}
