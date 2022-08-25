import 'package:firebase_remote_config/firebase_remote_config.dart';

const remoteColor = 'importanceColor';

class RemoteConfigRepository {

  static final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  static Future<void> initConfig() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 3),
        minimumFetchInterval: const Duration(seconds: 2),
      ),
    );

   // await fetchConfig();
  }

  Future<void> fetchConfig() async {
    await remoteConfig.fetchAndActivate();
  }

  String getSpecialColor() {
    return remoteConfig.getString(remoteColor);
  }

}
