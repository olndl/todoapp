import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/localization/l10n/all_locales.dart';
import '../../../viewmodel/todolist/filter_todo_viewmodel.dart';
import '../../../viewmodel/todolist/todo_list_viewmodel.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final TodoListViewModel todoListViewModel;
  final double expandedHeight;

  MySliverAppBar({
    required this.todoListViewModel,
    required this.expandedHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = shrinkOffset / maxExtent;
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        ColoredBox(
          color: ColorApp.lightTheme.backPrimary,
        ),
        AnimatedOpacity(
          opacity: shrinkOffset / expandedHeight,
          duration: const Duration(milliseconds: 150),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  AllLocale.of(context).title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: expandedHeight / 1.7 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 6,
          child: AnimatedOpacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            duration: const Duration(milliseconds: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AllLocale.of(context).title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 100,
                ),
                Text(
                  '${AllLocale.of(context).subtitle} ${todoListViewModel.getCountComplete()}',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
        ),
        Consumer(builder: (BuildContext context, WidgetRef ref, _) {
          final filterKindViewModel =
              ref.watch(filterKindViewModelStateNotifierProvider.notifier);
          return Positioned(
            child: AnimatedContainer(
              padding: EdgeInsets.lerp(
                EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 1.25,
                  top: MediaQuery.of(context).size.height / 6.4,
                ),
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 1.25),
                progress,
              ),
              duration: const Duration(milliseconds: 10),
              child: InputChip(
                label: filterKindViewModel.isFilteredByAll()
                    ? SvgPicture.asset(S.iconVisibility)
                    : SvgPicture.asset(S.iconVisibilityOff),
                selected: filterKindViewModel.isFilteredByAll(),
                onSelected: (val) => val
                    ? filterKindViewModel.filterByAll()
                    : filterKindViewModel.filterByIncomplete(),
                selectedColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                showCheckmark: false,
              ),
            ),
          );
        }),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
