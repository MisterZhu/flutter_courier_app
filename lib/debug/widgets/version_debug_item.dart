import 'package:courier_app/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionDebugItem extends StatefulWidget {
  const VersionDebugItem({super.key});

  @override
  State<VersionDebugItem> createState() => _VersionDebugItemState();
}

class _VersionDebugItemState extends State<VersionDebugItem> {
  // 公共样式
  static const _listTileTitleStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  static const _listTileSubtitleStyle =
      TextStyle(color: Colors.black, fontSize: 15);
  static const _listTileSubtitleValueStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue);

  // APP名称
  String _appName = '';
  // 包名
  String _packageName = '';
  // 版本号
  String _version = '';
  // 构建号
  String _buildNumber = '';

  @override
  void initState() {
    // 获取App info
    getPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InlineSpan span = TextSpan(children: [
      const TextSpan(
        text: 'Current version: ',
        style: _listTileSubtitleStyle,
      ),
      TextSpan(
        text: _version,
        style: _listTileSubtitleValueStyle,
      ),
      const TextSpan(
        text: '\n',
      ),
      const TextSpan(
        text: 'Current build number: ',
        style: _listTileSubtitleStyle,
      ),
      TextSpan(
        text: _buildNumber,
        style: _listTileSubtitleValueStyle,
      ),
    ]);
    return ListTile(
      title: const Text(
        'Version',
        style: _listTileTitleStyle,
      ),
      subtitle: Text.rich(span),
      // onTap: () {
      //   _showProxyConfig();
      // },
    );
    ;
  }

  /// 获取APP信息
  void getPackageInfo() async {
    PackageInfo packageInfo = await DeviceUtils.getPackageInfo();
    _appName = packageInfo.appName;
    _packageName = packageInfo.packageName;
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
    setState(() {});
  }
}
