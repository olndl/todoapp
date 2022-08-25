import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../viewmodel/todolist/filter_todo_viewmodel.dart';
import '../../../viewmodel/todolist/todo_list_viewmodel.dart';
import 'app_bar_delegate.dart';


class AppBarWidget extends StatelessWidget {
  final _provider = filterKindViewModelStateNotifierProvider;
  final _listprovider = todoListViewModelStateNotifierProvider;

  @override
  Widget build(final BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final viewModel = ref.watch(_provider.notifier);
        ref.watch(_provider);
        final todoListState = ref.watch(_listprovider.notifier);
        ref.watch(_listprovider);
        return SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: MySliverAppBar(
            viewModel: viewModel,
            expandedHeight: 150,
            numberOfCompleteTodo: todoListState.getCountComplete() != null
                ? '${todoListState.getCountComplete()}'
                : AllLocale.of(context).loading,
          ),
        );
      },
    );
  }
}
