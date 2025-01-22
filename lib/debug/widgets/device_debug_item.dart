import 'package:courier_app/utils/device_utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceDebugItem extends StatefulWidget {
  const DeviceDebugItem({super.key});

  @override
  State<DeviceDebugItem> createState() => _DeviceDebugItemState();
}

class _DeviceDebugItemState extends State<DeviceDebugItem> {
  // 公共样式
  static const _listTileTitleStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  static const _listTileSubtitleStyle =
      TextStyle(color: Colors.black, fontSize: 15);
  static const _listTileSubtitleValueStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue);

  // 设备基础信息
  String _deviceBase = '';
  // android版本
  String _androidSDKInt = '';
  // android版本
  String _androidId = '';

  @override
  void initState() {
    // 获取设备信息
    getDeviceInfo();
    // 获取安卓设备id
    getAndroidId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InlineSpan span = TextSpan(children: [
      const TextSpan(
        text: 'Device base: ',
        style: _listTileSubtitleStyle,
      ),
      TextSpan(
        text: _deviceBase,
        style: _listTileSubtitleValueStyle,
      ),
      const TextSpan(
        text: '\n',
      ),
      const TextSpan(
        text: 'Android SDK int: ',
        style: _listTileSubtitleStyle,
      ),
      TextSpan(
        text: _androidSDKInt,
        style: _listTileSubtitleValueStyle,
      ),
      const TextSpan(
        text: '\n',
      ),
      const TextSpan(
        text: 'Android device id: ',
        style: _listTileSubtitleStyle,
      ),
      TextSpan(
        text: _androidId,
        style: _listTileSubtitleValueStyle,
      ),
    ]);
    return ListTile(
      title: const Text(
        'Device',
        style: _listTileTitleStyle,
      ),
      subtitle: Text.rich(span),
      // onTap: () {
      //   _showProxyConfig();
      // },
    );
  }

  /// 获取APP信息
  void getDeviceInfo() async {
    AndroidDeviceInfo androidInfo = await DeviceUtils.getAndroidDeviceInfo();
    AndroidBuildVersion buildVersion = androidInfo.version;
    _deviceBase = '${buildVersion.baseOS}';
    _androidSDKInt = '${buildVersion.sdkInt}';
    setState(() {});
  }

  // 获取安卓设备id
  void getAndroidId() async {
    String androidId = await DeviceUtils.getAndroidId();
    _androidId = androidId;
    setState(() {});
  }
}
