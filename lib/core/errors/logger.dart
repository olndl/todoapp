import 'dart:developer' as dev;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../constants/strings.dart';

final logger = Logger('');

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
    case S.addLog:
      FirebaseAnalytics.instance
          .logEvent(name: S.addLog, parameters: {'full_text': title});
      break;
    case S.deleteLog:
      FirebaseAnalytics.instance
          .logEvent(name: S.deleteLog, parameters: {'full_text': title});
      break;
    case S.completeLog:
      FirebaseAnalytics.instance
          .logEvent(name: S.completeLog, parameters: {'full_text': title});
      break;
  }
}
