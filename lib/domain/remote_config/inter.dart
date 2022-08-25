import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../data/remote_config/remote_config_repository.dart';

class GetRemoteConfigValuesInteractor {
  GetRemoteConfigValuesInteractor(this._remoteConfigRepository);

  final RemoteConfigRepository _remoteConfigRepository;

  String getNameValidationRegEx() {
    return _remoteConfigRepository.getSpecialColor();
  }
}
