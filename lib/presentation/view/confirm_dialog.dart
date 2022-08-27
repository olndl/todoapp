import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/navigation/controller.dart';

extension DialogExt on BuildContext {
  Future<bool?> showConfirmationDialog(
      Widget title,
      Widget content,
      ) async {
    final controller = read<NavigationController>();
   return controller.pushDialog<bool?>(
        DialogRoute(
          context: this,
          builder: (_) => AlertDialog(
            title: title,
            content: content,
            actions: [
              TextButton(
                  child: const Text('OK'),
                  onPressed: () => read<NavigationController>().pop(true)),
              TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => read<NavigationController>().pop(false)),
            ],
          ),
        ),
      );
    }
  }
