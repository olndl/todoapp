import 'dart:ui';

import 'package:flutter/material.dart';

abstract class ColorApp {
  static final lightTheme = Light();
  static final darkTheme = Dark();
}

class Light {
  final Color backPrimary = const Color(0xfffcfaf1);
  final Color backSecondary = const Color(0xffffffff);
  final Color backElevated = const Color(0xffffffff);

  final Color colorRed = const Color(0xffff3b30);
  final Color colorGreen = const Color(0xff34c759);
  final Color colorBlue = const Color(0xff007aff);
  final Color colorGrey = const Color(0xff8e8e93);
  final Color colorGreyLight = const Color(0xffd1d1d6);
  final Color colorWhite = const Color(0xffffffff);

  final Color labelPrimary = const Color(0xff000000);
  final Color labelSecondary = const Color(0x99000000);
  final Color labelTertiary = const Color(0x4d000000);
  final Color labelDisable = const Color(0x26000000);

  final Color supportSeparator = const Color(0x33000000);
  final Color supportOverlay = const Color(0x0f000000);
}

class Dark {
  final Color backPrimary = const Color(0xff161618);
  final Color backSecondary = const Color(0xff252528);
  final Color backElevated = const Color(0xff3c3c3f);

  final Color colorRed = const Color(0xffff3b30);
  final Color colorGreen = const Color(0xff34c759);
  final Color colorBlue = const Color(0xff007aff);
  final Color colorGrey = const Color(0xff8e8e93);
  final Color colorGreyLight = const Color(0xffd1d1d6);
  final Color colorWhite = const Color(0xffffffff);

  final Color labelPrimary = const Color(0xffffffff);
  final Color labelSecondary = const Color(0x99ffffff);
  final Color labelTertiary = const Color(0x66ffffff);
  final Color labelDisable = const Color(0x26ffffff);

  final Color supportSeparator = const Color(0x33ffffff);
  final Color supportOverlay = const Color(0x52000000);
}
