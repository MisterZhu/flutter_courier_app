import 'package:courier_app/debug/widgets/database_debug_item.dart';
import 'package:courier_app/debug/widgets/device_debug_item.dart';
import 'package:courier_app/debug/widgets/version_debug_item.dart';
import 'package:flutter/material.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> debugList = const [
      // 设备
      DeviceDebugItem(),
      // 版本
      VersionDebugItem(),
      // 数据库
      DatabaseDebugItem(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: false,
              itemCount: debugList.length,
              itemBuilder: (BuildContext context, int index) {
                return debugList[index];
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 1.0,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
