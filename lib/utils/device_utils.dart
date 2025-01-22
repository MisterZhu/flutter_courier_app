import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class DeviceUtils {
  // 获取设备信息
  static Future<AndroidDeviceInfo> getAndroidDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    debugPrint(
        'Android Device Info: ${androidInfo.board}, ${androidInfo.bootloader}, ${androidInfo.brand}, ${androidInfo.device}, ${androidInfo.display}, ${androidInfo.fingerprint}, ${androidInfo.hardware}, ${androidInfo.host}, ${androidInfo.id}, ${androidInfo.manufacturer}, ${androidInfo.model}, ${androidInfo.product}, ${androidInfo.supported32BitAbis}, ${androidInfo.supported64BitAbis}, ${androidInfo.supportedAbis}, ${androidInfo.tags}, ${androidInfo.type}, ${androidInfo.isPhysicalDevice}, ${androidInfo.systemFeatures}, ${androidInfo.serialNumber}');
    return androidInfo;
  }

  // 获取安卓设备id
  static Future<String> getAndroidId() async {
    const androidIdPlugin = AndroidId();
    String androidId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      androidId = await androidIdPlugin.getId() ?? 'Unknown ID';
    } on PlatformException {
      androidId = 'Failed to get Android ID.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    debugPrint('Android Id: $androidId');

    return androidId;
  }

  // 获取包信息
  static Future<PackageInfo> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    debugPrint(
        'Package Info: ${packageInfo.appName}, ${packageInfo.packageName}, ${packageInfo.version}, ${packageInfo.buildNumber}, ${packageInfo.buildSignature}, ${packageInfo.installerStore} ');
    return packageInfo;
  }
}
