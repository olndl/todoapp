import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/strings.dart';
import '../../../../data/remote_config/remote_config_repository.dart';

class PriorityIconWidget extends StatefulWidget {
  final String importance;

  const PriorityIconWidget({Key? key, required this.importance})
      : super(key: key);

  @override
  State<PriorityIconWidget> createState() => _PriorityIconWidgetState();
}

class _PriorityIconWidgetState extends State<PriorityIconWidget> {
  late RemoteConfigRepository _remoteConfigRepository;

  @override
  void initState() {
    super.initState();
    _remoteConfigRepository.getRemoteConfig;
    _remoteConfigRepository.initConfig();
  }

  @override
  Widget build(BuildContext context) {
    return widget.importance == S.basic
        ? Padding(
            padding: const EdgeInsets.all(6.0),
            child: SvgPicture.asset(
              S.iconArrow,
            ),
          )
        : (widget.importance == S.important
            ? Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(S.iconPriority,
                    color: RemoteConfigRepository.defaultRemoteConfigColors[
                        _remoteConfigRepository.getColorValue.isNotEmpty
                            ? _remoteConfigRepository.getColorValue
                            : RemoteConfigRepository.defaultImportanceColor]

                    //ColorApp.lightTheme.colorRed,
                    ),
              )
            : const SizedBox.shrink());
  }
}
