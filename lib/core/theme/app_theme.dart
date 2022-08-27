import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: ColorApp.lightTheme.backPrimary,
      scaffoldBackgroundColor: ColorApp.lightTheme.backPrimary,
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

      textTheme: TextTheme(
        // Large title 32/38
        headline5: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          height: 38 / 32,
          letterSpacing: 0,
        ),
        // title 20/32
        headline6: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          height: 32 / 20,
          color: ColorApp.lightTheme.labelPrimary,
          letterSpacing: .5,
        ),
        headline4: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: ColorApp.lightTheme.labelPrimary,
          height: 32 / 20,
          letterSpacing: .5,
        ),
        headline1: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          height: 20 / 16,
          color: ColorApp.lightTheme.colorGrey,
          decoration: TextDecoration.lineThrough,
          letterSpacing: 0,
        ),
        subtitle2: TextStyle(
          fontSize: 18.0,
          color: ColorApp.lightTheme.colorGrey,
        ),
        button: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w800,
          height: 24 / 14,
          color: ColorApp.lightTheme.colorBlue,
          letterSpacing: .16,
        ),
        bodyText1: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          height: 20 / 16,
          letterSpacing: 0,
        ),
        bodyText2: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          height: 20 / 16,
          color: ColorApp.lightTheme.colorGrey,
          letterSpacing: 0,
        ),
        subtitle1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: ColorApp.lightTheme.colorGrey,
          height: 20 / 14,
          letterSpacing: 0,
        ),
      ),
      // listTileTheme: (),
      cardTheme: CardTheme(
        color: ColorApp.lightTheme.colorWhite,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorApp.lightTheme.backSecondary, width: 1),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorApp.lightTheme.colorBlue,
        foregroundColor: ColorApp.lightTheme.colorWhite,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: ColorApp.darkTheme.backPrimary,
      scaffoldBackgroundColor: ColorApp.darkTheme.backPrimary,
      indicatorColor: ColorApp.darkTheme.colorBlue,
      iconTheme: IconThemeData(color: ColorApp.darkTheme.colorBlue),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        color: ColorApp.darkTheme.backPrimary,
        iconTheme: IconThemeData(
          color: ColorApp.darkTheme.colorBlue,
        ),
      ),

      fontFamily: 'Roboto',

      textTheme: TextTheme(
        // Large title 32/38
        headline5: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          height: 38 / 32,
          letterSpacing: 0,
        ),
        // title 20/32
        headline6: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          height: 32 / 20,
          color: ColorApp.darkTheme.labelPrimary,
          letterSpacing: .5,
        ),
        headline4: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: ColorApp.darkTheme.labelPrimary,
          height: 32 / 20,
          letterSpacing: .5,
        ),
        headline1: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          height: 20 / 16,
          color: ColorApp.darkTheme.colorGrey,
          decoration: TextDecoration.lineThrough,
          letterSpacing: 0,
        ),
        subtitle2: TextStyle(
          fontSize: 18.0,
          color: ColorApp.darkTheme.colorGrey,
        ),
        button: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w800,
          height: 24 / 14,
          color: ColorApp.darkTheme.colorBlue,
          letterSpacing: .16,
        ),
        bodyText1: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          height: 20 / 16,
          letterSpacing: 0,
        ),
        bodyText2: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          height: 20 / 16,
          color: ColorApp.darkTheme.colorGrey,
          letterSpacing: 0,
        ),
        subtitle1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: ColorApp.darkTheme.colorGrey,
          height: 20 / 14,
          letterSpacing: 0,
        ),
      ),
      // listTileTheme: (),

      cardTheme: CardTheme(
        color: ColorApp.darkTheme.backSecondary,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorApp.darkTheme.backSecondary, width: 1),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorApp.darkTheme.colorBlue,
        foregroundColor: ColorApp.darkTheme.colorWhite,
      ),
    );
  }
}
