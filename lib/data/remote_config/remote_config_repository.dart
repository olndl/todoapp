import 'package:firebase_remote_config/firebase_remote_config.dart';
import '../../core/constants/colors.dart';

const remoteColor = 'importanceColor';

class RemoteConfigRepository {

  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  static String defaultImportanceColor = 'red';

  static Map<String, dynamic> defaultRemoteConfigColors = {
    'purple': ColorApp.lightTheme.colorSpecial,
    'red': ColorApp.lightTheme.colorRed,
  };

  String get getColorValue => remoteConfig.getString(remoteColor);
  FirebaseRemoteConfig get getRemoteConfig => FirebaseRemoteConfig.instance;

  Future<void> initConfig() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 3),
        minimumFetchInterval: const Duration(seconds: 2),
      ),
    );
    await fetchConfig();
  }

  Future<void> fetchConfig() async {
    await remoteConfig.fetchAndActivate();
  }
}
