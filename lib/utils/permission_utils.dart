import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dialog_utils.dart';

abstract class PermissionUtils {
  //     await Permission.camera.onDeniedCallback(() {
  //       // 用户被拒绝访问所请求的功能，需要先申请权限。
  //     }).onGrantedCallback(() {
  //       // 用户获准访问所请求的功能。
  //     }).onRestrictedCallback(() {
  //       // 操作系统拒绝访问请求的功能。用户无法更改此应用程序的状态，这可能是由于设置了家长控制等有效限制。仅限 iOS
  //     }).onLimitedCallback(() {
  //       // 用户已授权该应用程序进行有限访问。到目前为止，这只适用于照片库拾取器。仅限 iOS (iOS14+)
  //     }).onPermanentlyDeniedCallback(() {
  //       // 永久拒绝所请求功能的权限，请求该权限时将不会显示权限对话框。用户仍可在设置中更改权限状态。
  //       // 在安卓系统上： Android 11+ (API 30+)：用户是否第二次拒绝权限。低于 Android 11 (API30)：用户是否拒绝访问请求的功能并选择不再显示请求。
  //       // 在 iOS 上： 如果用户拒绝访问请求的功能。
  //     }).onProvisionalCallback(() {
  //       // 该应用程序已获得临时授权，可发布非中断用户通知。仅限 iOS（iOS12+）
  //     }).request();

  /// 相机权限
  static Future<bool> checkCameraPermission() async {
    try {
      // 获取状态
      final PermissionStatus status = await Permission.camera.status;
      debugPrint('''
          相机权限状态:
          isDenied:${status.isDenied}
          isGranted:${status.isGranted}
          isRestricted:${status.isRestricted}
          isLimited:${status.isLimited}
          isPermanentlyDenied:${status.isPermanentlyDenied}
          isProvisional:${status.isProvisional}
          ''');
      if (status.isDenied == true) {
        // 申请权限
        await Permission.camera.request();
        debugPrint('相机权限申请');
        return false;
      } else if (status.isGranted == false) {
        showSettingAlert('Please enable camera permissions in setting.');
        return false;
      }
      return true;
    } catch (error) {
      debugPrint('相机权限打开失败: $error');
      return false;
    }
  }

  /// 资源库权限
  static Future<bool> checkMediaLibraryPermission() async {
    try {
      // 获取状态
      final PermissionStatus status = await Permission.mediaLibrary.status;
      debugPrint('''
          资源库权限状态:
          isDenied:${status.isDenied}
          isGranted:${status.isGranted}
          isRestricted:${status.isRestricted}
          isLimited:${status.isLimited}
          isPermanentlyDenied:${status.isPermanentlyDenied}
          isProvisional:${status.isProvisional}
          ''');
      if (status.isDenied == true) {
        // 申请权限
        await Permission.mediaLibrary.request();
        debugPrint('资源库权限申请');
        return false;
      } else if (status.isGranted == false) {
        showSettingAlert('Please enable media library permissions in setting.');
        return false;
      }
      return true;
    } catch (error) {
      debugPrint('资源库权限打开失败: $error');
      return false;
    }
  }

  /// 定位权限
  static Future<bool> checkLocationPermission() async {
    try {
      // 获取状态
      final PermissionStatus status = await Permission.locationWhenInUse.status;
      debugPrint('''
          定位权限状态:
          isDenied:${status.isDenied}
          isGranted:${status.isGranted}
          isRestricted:${status.isRestricted}
          isLimited:${status.isLimited}
          isPermanentlyDenied:${status.isPermanentlyDenied}
          isProvisional:${status.isProvisional}
          ''');
      if (status.isDenied == true) {
        // 申请权限
        await Permission.locationWhenInUse.request();
        debugPrint('定位权限申请');
        return false;
      } else if (status.isGranted == false) {
        showSettingAlert('Please enable location permissions in setting.');
        return false;
      }
      return true;
    } catch (error) {
      debugPrint('定位权限打开失败: $error');
      return false;
    }
  }

  static void showSettingAlert(String content) {
    // 展示跳转设置的弹窗
    DialogUtils.showPrimaryDialog(
      content: content,
      positiveText: 'Go to setting',
      negativeText: 'Cancel',
      positiveAction: () {
        openAppSettings();
      },
    );
  }
}
