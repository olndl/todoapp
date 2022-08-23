import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/presentation/view/todo_add_edit_page.dart';
import 'package:todoapp/presentation/view/todo_list_page.dart';
import 'package:todoapp/presentation/viewmodel/unknown_page.dart';
import 'core/errors/logger.dart';
import 'core/navigation/controller.dart';
import 'core/navigation/router.dart';
import 'core/localization/l10n/all_locales.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/navigation/routes.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/controller.dart';
import 'domain/model/todo.dart';
import 'firebase_options.dart';

void main() {
  // runZonedGuarded(() async {
  //    WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform);

  initLogger();
  logger.info('Start main');
  //
  // await Hive.initFlutter();
  // Hive.registerAdapter(TodoAdapter());
  // await Hive.openBox<Todo>('todo_box');
  runApp(
    ProviderScope(
      child: TodoApp(
        router: AppRouter(),
      ),
    ),
  );
  // },
  //     (error, stack) =>
  //         FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class TodoApp extends StatelessWidget {
  final AppRouter router;

  const TodoApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AllLocale.supportedLocales,
      theme: CustomTheme.lightTheme,
      initialRoute: Routes.LIST_TODO_ROUTE,
      onGenerateRoute: router.generateRoute,
    );
  }
}
