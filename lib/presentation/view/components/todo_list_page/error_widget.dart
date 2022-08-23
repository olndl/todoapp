import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final String error;
  const ErrorWidget(this.error);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 15,
      child: Text('An error has occurred! $error'),
    );
  }
}