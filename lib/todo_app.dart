import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/localization/l10n/all_locales.dart';
import 'core/navigation/delegate.dart';
import 'core/navigation/parser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/navigation/router.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/navigation/provider.dart';

import 'core/theme/app_theme.dart';

class TodoApp extends ConsumerWidget {

  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
    MaterialApp.router(
        //title: 'Riverpod Navigator Example',
        routerDelegate: ref.read(routerDelegateProvider),
        routeInformationParser: RouteInformationParserImpl(),
        debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AllLocale.supportedLocales,
      theme: CustomTheme.lightTheme,
    );



    //
    // final routeObserver = RouteObserver();
    // return Provider<RouteObserver>.value(
    //   value: routeObserver,
    //   child: kIsWeb || Platform.isAndroid
    //       ? Builder(
    //     builder: (context) {
    //       return MaterialApp.router(
    //         debugShowCheckedModeBanner: false,
    //         localizationsDelegates: const [
    //           AppLocalizations.delegate,
    //           GlobalMaterialLocalizations.delegate,
    //           GlobalWidgetsLocalizations.delegate,
    //           GlobalCupertinoLocalizations.delegate,
    //         ],
    //         supportedLocales: AllLocale.supportedLocales,
    //         theme: CustomTheme.lightTheme,
    //
    //         routerDelegate: BookshelfRouterDelegate(),
    //         routeInformationParser: BooksShelfRouteInformationParser(),
    //         routeInformationProvider: DebugRouteInformationProvider(),
    //       );
    //     },
    //   )
    //       : Builder(
    //     builder: (context) {
    //       return CupertinoApp.router(
    //         routerDelegate: BookshelfRouterDelegate(),
    //         routeInformationParser: BooksShelfRouteInformationParser(),
    //         routeInformationProvider: DebugRouteInformationProvider(),
    //       );
    //     },
    //   ),
    // );
  }
