import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/navigation/controller.dart';
import 'package:todoapp/presentation/screens/task_editing_screen.dart';
import 'package:todoapp/presentation/screens/task_list_screen.dart';

import 'core/navigation/routes.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/l10n/all_locales.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _locale = AllLocale.ru;

  @override
  Widget build(BuildContext context) {
    final navigationController = NavigationController();
    final routeObserver = RouteObserver();
    return Provider<NavigationController>.value(
      value: navigationController,
      child: Provider<RouteObserver>.value(
        value: routeObserver,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightThemeData,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AllLocale.supportedLocales,
          locale: _locale,
          initialRoute: Routes.list,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case Routes.list:
                return MaterialPageRoute(builder: (_) => const TaskHomeScreen());
              case Routes.details:
                return MaterialPageRoute(
                    builder: (_) => const TaskDetailsScreen());
            }
          },
          navigatorKey: navigationController.key,
        ),
      ),
    );
  }
}
