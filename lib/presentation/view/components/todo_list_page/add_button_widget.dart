import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/navigation/model.dart';
import '../../../../core/navigation/provider.dart';

class AddTodoButtonWidget extends ConsumerWidget {
  const AddTodoButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () => {
        ref.read(routerDelegateProvider).navigate([
          ListTodoSegment(),
          CreateTodoSegment(todo: null),
        ])
      },
      child: const Icon(Icons.add),
    );
  }
}
