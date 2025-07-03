import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtils {
  DeviceUtils._();

  static final DeviceUtils _shared = DeviceUtils._();

  factory DeviceUtils() => _shared;

  final _deviceInfoPlugin = DeviceInfoPlugin();

  Future<String?> getClientId() async {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor;
    }

    return null;
  }
}
