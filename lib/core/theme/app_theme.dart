import 'package:flutter/material.dart';

import '../constants/colors.dart';

ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: ColorApp.backLightPrimary,
  primaryColor: ColorApp.backLightSecondary,
  primarySwatch: Colors.green,
  indicatorColor: Colors.blue,
  iconTheme: const IconThemeData(color: Colors.blue),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    color: ColorApp.backLightPrimary,
    iconTheme: IconThemeData(
      color: Colors.blue,
    ),
  ),
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    headline5: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
    subtitle2: TextStyle(
      fontSize: 20.0,
    ),
    button: TextStyle(
      fontSize: 14.0,
    ),
    bodyText1: TextStyle(
      fontSize: 16.0,
    ),
    subtitle1: TextStyle(fontSize: 14.0),
  ),
  cardTheme: const CardTheme(
    color: ColorApp.backLightSecondary,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: ColorApp.backLightSecondary, width: 1),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue, foregroundColor: Colors.white),
);

ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: ColorApp.backDarkPrimary,
  primaryColor: ColorApp.backDarkSecondary,
  primarySwatch: Colors.green,
  indicatorColor: Colors.blue,
  iconTheme: const IconThemeData(color: Colors.grey),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    color: ColorApp.backDarkPrimary,
    iconTheme: IconThemeData(
      color: Colors.grey,
    ),
  ),
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    headline5: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
    subtitle2: TextStyle(
      fontSize: 20.0,
    ),
    button: TextStyle(
      fontSize: 14.0,
    ),
    bodyText1: TextStyle(
      fontSize: 16.0,
    ),
    subtitle1: TextStyle(fontSize: 14.0),
  ),
  cardTheme: const CardTheme(
    color: ColorApp.backDarkElevated,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: ColorApp.backDarkElevated, width: 1),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue, foregroundColor: Colors.white),
);
