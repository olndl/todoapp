import 'package:flutter/cupertino.dart';

import '../localization/l10n/all_locales.dart';


class Dim {
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;
}
