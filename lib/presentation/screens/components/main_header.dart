import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/localization/l10n/all_locales.dart';

class MainHeader extends StatefulWidget {
  final int numberOfCompleteTodo;

  const MainHeader({Key? key, required this.numberOfCompleteTodo})
      : super(key: key);

  @override
  State<MainHeader> createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: MySliverAppBar(
          expandedHeight: 150,
          numberOfCompleteTodo: widget.numberOfCompleteTodo),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final int numberOfCompleteTodo;
  final double expandedHeight;

  MySliverAppBar(
      {required this.numberOfCompleteTodo, required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
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
                  '${AllLocale.of(context).subtitle} $numberOfCompleteTodo',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          child: AnimatedContainer(
            padding: EdgeInsets.lerp(
              EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 1.3,
                  top: MediaQuery.of(context).size.height / 6.4),
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 1.3),
              progress,
            ),
            duration: const Duration(milliseconds: 150),
            child: IconButton(
                onPressed: () {
                  debugPrint("жмяк на нижний");
                },
                icon: Icon(Icons.visibility)),
          ),
        ),
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
