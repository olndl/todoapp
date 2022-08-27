import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/navigation/delegate.dart';
import '../../../../core/navigation/model.dart';
import '../../../../core/navigation/provider.dart';
import '../../../../core/navigation/routes.dart';

class AddTodoButtonWidget extends ConsumerWidget {
  const AddTodoButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () =>   {
        ref.read(routerDelegateProvider).navigate([
          HomeSegment(),
          BookSegment(todo: null),])
        //(Router.of(context).routerDelegate as BookshelfRouterDelegate).gotoCreateTodo()
      },
      child: const Icon(Icons.add),
    );
  }
}
