import 'package:flutter/material.dart';
import 'package:todoapp/core/constants/dimension.dart';

class UnknownPage extends StatelessWidget {
  final String? name;

  const UnknownPage(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const FlutterLogo(
          size: 80,
        ),
        Text('Unknown page: $name'),
      ],
    );
  }
}
