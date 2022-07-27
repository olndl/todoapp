import 'dart:ui';

import 'package:flutter/material.dart';

abstract class ColorApp {
  static final lightTheme = Light();
  static final darkTheme = Dark();
}

class Light {
  final Color backPrimary = Color(0xfff7f6f2);
  final Color backSecondary = Color(0xffffffff);
  final Color backElevated = Color(0xffffffff);

  final Color colorRed = Color(0xffff3b30);
  final Color colorGreen = Color(0xff34c759);
  final Color colorBlue = Color(0xff007aff);
  final Color colorGrey = Color(0xff8e8e93);
  final Color colorGreyLight = Color(0xffd1d1d6);
  final Color colorWhite = Color(0xffffffff);

  final Color labelPrimary = Color(0xff000000);
  final Color labelSecondary = Color(0x99000000);
  final Color labelTertiary = Color(0x4d000000);
  final Color labelDisable = Color(0x26000000);

  final Color supportSeparator = Color(0x33000000);
  final Color supportOverlay = Color(0x0f000000);
}

class Dark {
  final Color backPrimary = Color(0xff161618);
  final Color backSecondary = Color(0xff252528);
  final Color backElevated = Color(0xff3c3c3f);

  final Color colorRed = Color(0xffff3b30);
  final Color colorGreen = Color(0xff34c759);
  final Color colorBlue = Color(0xff007aff);
  final Color colorGrey = Color(0xff8e8e93);
  final Color colorGreyLight = Color(0xffd1d1d6);
  final Color colorWhite = Color(0xffffffff);

  final Color labelPrimary = Color(0xffffffff);
  final Color labelSecondary = Color(0x99ffffff);
  final Color labelTertiary = Color(0x66ffffff);
  final Color labelDisable = Color(0x26ffffff);

  final Color supportSeparator = Color(0x33ffffff);
  final Color supportOverlay = Color(0x52000000);
}
