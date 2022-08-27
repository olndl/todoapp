import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/todo_app.dart';
import 'core/errors/logger.dart';
import 'core/navigation/router.dart';
import 'domain/model/todo.dart';
import 'firebase_options.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      initLogger();
      logger.info('Start main');
      runApp(
        ProviderScope(
          child: TodoApp(
          ),
        ),
      );
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}

class NavigationStateDTO {
  bool todos;
  bool todoIdCreate;
  Todo? todoIdEdit;
  NavigationStateDTO(this.todos, this.todoIdCreate, this.todoIdEdit);
  NavigationStateDTO.todos()
      : todos = true,
        todoIdCreate = false,
        todoIdEdit = null;
  NavigationStateDTO.todoIdCreate()
      : todos = false,
        todoIdCreate = true,
        todoIdEdit = null;
  NavigationStateDTO.todoIdEdit(Todo todo)
      : todos = false,
        todoIdCreate = false,
        todoIdEdit = todo;
}

