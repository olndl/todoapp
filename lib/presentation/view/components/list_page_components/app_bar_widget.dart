import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../viewmodel/todolist/filter_todo_viewmodel.dart';
import '../../../viewmodel/todolist/todo_list_viewmodel.dart';
import 'delegate_widget.dart';

class AppBarWidget extends StatelessWidget {
  final _filterProvider = filterKindViewModelStateNotifierProvider;
  final _listProvider = todoListViewModelStateNotifierProvider;

  @override
  Widget build(final BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final filterKindViewModel = ref.watch(_filterProvider.notifier);
        final todoListViewModel = ref.watch(_listProvider.notifier);
        return SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: MySliverAppBar(
            filterKindViewModel: filterKindViewModel,
            todoListViewModel: todoListViewModel,
            expandedHeight: 150,
          ),
        );
      },
    );
  }
}
