import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';

class PriorityIconWidget extends StatelessWidget {
  final String importance;

  const PriorityIconWidget({Key? key, required this.importance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return importance == S.basic
        ? Padding(
            padding: const EdgeInsets.all(6.0),
            child: SvgPicture.asset(
              S.iconArrow,
            ),
          )
        : (importance == S.important
            ? Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                  S.iconPriority,
                  color: ColorApp.lightTheme.colorRed,
                ),
              )
            : const SizedBox.shrink());
  }
}
