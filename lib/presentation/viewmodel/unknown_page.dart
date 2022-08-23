import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  final String? name;
  const UnknownPage(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FlutterLogo(),
        Text('Unknown page: $name'),
      ],
    );
  }
}