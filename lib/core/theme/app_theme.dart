import 'package:flutter/material.dart';
import '../constants/colors.dart';

ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: ColorApp.lightTheme.backPrimary,
  primaryColor: ColorApp.lightTheme.colorBlue,
  //primarySwatch: _primarySwatch,
  indicatorColor: ColorApp.lightTheme.colorBlue,
  iconTheme: IconThemeData(color: ColorApp.lightTheme.colorBlue),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(
    color: ColorApp.lightTheme.backPrimary,
    iconTheme: IconThemeData(
      color: ColorApp.lightTheme.colorBlue,
    ),
  ),

  fontFamily: 'Roboto',

  textTheme:const TextTheme(
    // Large title 32/38
    headline5: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w500,
      height: 38 / 32,
      letterSpacing: 0,
    ),
    // title 20/32
    headline6: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        height: 32 / 20,
        color: Colors.black,
        letterSpacing: .5),
    headline4: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        height: 32 / 20,
        letterSpacing: .5),
    subtitle2: TextStyle(
      fontSize: 20.0,
    ),
    button: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        height: 24 / 14,
        letterSpacing: .16),
    bodyText1: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        height: 20 / 16,
        letterSpacing: 0),
    subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        height: 20 / 14,
        letterSpacing: 0),
  ),
  // listTileTheme: (),

  cardTheme: CardTheme(
    color: ColorApp.lightTheme.backPrimary,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: ColorApp.lightTheme.backSecondary, width: 1),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorApp.lightTheme.colorBlue,
      foregroundColor: ColorApp.lightTheme.colorWhite),
);

ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: ColorApp.darkTheme.backPrimary,
  primaryColor: ColorApp.darkTheme.backSecondary,
  primarySwatch: Colors.green,
  indicatorColor: Colors.blue,
  iconTheme: const IconThemeData(color: Colors.grey),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(
    color: ColorApp.darkTheme.backPrimary,
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
  cardTheme: CardTheme(
    color: ColorApp.darkTheme.backElevated,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: ColorApp.darkTheme.backElevated, width: 1),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorApp.darkTheme.colorBlue,
      foregroundColor: ColorApp.darkTheme.colorWhite),
);
