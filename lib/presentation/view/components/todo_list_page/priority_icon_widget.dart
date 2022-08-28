import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';

class PriorityIconWidget extends StatefulWidget {
  final String importance;

  const PriorityIconWidget({Key? key, required this.importance})
      : super(key: key);

  @override
  State<PriorityIconWidget> createState() => _PriorityIconWidgetState();
}

class _PriorityIconWidgetState extends State<PriorityIconWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.importance == S.api.basic
        ? Padding(
            padding: const EdgeInsets.all(6.0),
            child: SvgPicture.asset(
              S.appIcons.iconArrow,
            ),
          )
        : (widget.importance == S.api.important
            ? Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                  S.appIcons.iconPriority,
                  color: ColorApp.lightTheme.colorRed,
                ),
              )
            : const SizedBox.shrink());
  }
}
