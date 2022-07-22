import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  var _locale = AllLocale.en;
  var _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.theme(_isDark),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AllLocale.supportedLocales,
      locale: _locale,
      builder: (context, child) => SafeArea(
        child: Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(AllLocale.of(context).helloWorld),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkResponse(
                    child: Text(_locale.languageCode.toUpperCase()),
                    onTap: () {
                      final newLocale =
                          AllLocale.isEn(_locale) ? AllLocale.ru : AllLocale.en;
                      setState(() {
                        _locale = newLocale;
                      });
                    },
                  ),
                  InkResponse(
                    child: Icon(
                        _isDark ? Icons.light_mode : Icons.nightlight_outlined),
                    onTap: () {
                      final newMode = !_isDark;
                      setState(() => _isDark = newMode);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
