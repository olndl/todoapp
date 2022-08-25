import 'package:firebase_remote_config/firebase_remote_config.dart';

const remoteColor = 'importanceColor';

class RemoteConfigRepository {
  RemoteConfigRepository(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  String getSpecialColor() {
    return _remoteConfig.getString(remoteColor);
  }

  Future<void> initConfig() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 3),
        minimumFetchInterval: const Duration(seconds: 2),
      ),
    );

    await _fetchConfig();
  }

  Future<void> _fetchConfig() async {
    await _remoteConfig.fetchAndActivate();
  }
}
