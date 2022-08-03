import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/navigation/controller.dart';
import 'core/navigation/router.dart';
import 'core/navigation/routes.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/l10n/all_locales.dart';

void main() {
  runApp(TodoApp(
    router: AppRouter(),
  ));
}

class TodoApp extends StatelessWidget {

  final AppRouter router;

  const TodoApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}



//
// void main() {
//   runApp(MyApp(
//     router: AppRouter(),
//   ));
// }
//
// class MyApp extends StatefulWidget {
//   final AppRouter router;
//   const MyApp({Key? key, required this.router}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final _locale = AllLocale.ru;
//
//   @override
//   Widget build(BuildContext context) {
//     final navigationController = NavigationController();
//     final routeObserver = RouteObserver();
//     return Provider<NavigationController>.value(
//       value: navigationController,
//       child: Provider<RouteObserver>.value(
//         value: routeObserver,
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: lightThemeData,
//           localizationsDelegates: const [
//             AppLocalizations.delegate,
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate,
//           ],
//           supportedLocales: AllLocale.supportedLocales,
//           locale: _locale,
//           initialRoute: Routes.list,
//           onGenerateRoute: widget.router.generateRoute,
//           navigatorKey: navigationController.key,
//         ),
//       ),
//     );
//   }
// }
