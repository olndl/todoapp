import 'dart:io';
import 'package:device_info/device_info.dart';

class DeviceId {

  Future<String> get deviceId => getDeviceDetails();

  Future<String> getDeviceDetails() async {
    String? deviceName;
    String? identifier;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      identifier = build.androidId;
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name;
      identifier = data.identifierForVendor;
    }
    return '${deviceName!}-${identifier!}';
  }
}
