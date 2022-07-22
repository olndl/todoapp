import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllLocale {
  static const en = Locale("en", "US");
  static const ru = Locale("ru", "RUS");

  static const supportedLocales = [en, ru];

  static bool isEn(Locale locale) => locale == en;

  static LocalizationsDelegate<AppLocalizations> get delegate =>
      AppLocalizations.delegate;

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;

}
