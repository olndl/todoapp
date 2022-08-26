import 'package:flutter/material.dart';
import 'package:todoapp/core/constants/dimension.dart';

class UnknownPage extends StatelessWidget {
  final String? name;

  const UnknownPage(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
        top: Dim.height(context) / 40,
        left: Dim.width(context) / 56,
        right: Dim.width(context) / 56,
        bottom: Dim.height(context) / 40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const FlutterLogo(
            size: 80,
          ),
          Text('Unknown page:\n $name'),
        ],
      ),
    );
  }
}
