import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/localization/l10n/all_locales.dart';

class AppHeader extends SliverPersistentHeaderDelegate {

  const AppHeader();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = shrinkOffset / maxExtent;

    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: 1,
            child: ColoredBox(
              color: ColorApp.lightTheme.backPrimary,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.lerp(
              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              EdgeInsets.only(bottom: 16),
              progress,
            ),
            alignment: Alignment.lerp(
              Alignment(-.4, 1),
              Alignment(-.8, 1),
              progress,
            ),
            child: Text(
              AllLocale.of(context).title,
              style: TextStyle.lerp(
                Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.black),
                Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.black),
                progress,
              ),
            ),
          ),
          AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              padding: EdgeInsets.lerp(
                EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                EdgeInsets.only(bottom: 16),
                progress,
              ),
              alignment: Alignment.lerp(
                Alignment(.8, 2.35),
                Alignment(.67, 2.2),
                progress,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 392 / 1.6),
                child:
                    IconButton(onPressed: () {}, icon: Icon(Icons.visibility)),
              )),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 84;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
