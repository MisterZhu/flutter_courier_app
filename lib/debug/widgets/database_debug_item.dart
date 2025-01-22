import 'package:courier_app/debug/widgets/database_debug_page.dart';
import 'package:courier_app/demo/database/database_page_demo.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:flutter/material.dart';

class DatabaseDebugItem extends StatelessWidget {
  const DatabaseDebugItem({super.key});

  // 公共样式
  static const _listTileTitleStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  static const _listTileTrailing = Icon(Icons.keyboard_arrow_right);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'Database viewer',
        style: _listTileTitleStyle,
      ),
      trailing: _listTileTrailing,
      onTap: () {
        // NavUtils.to(const DatabaseDebugPage());
        NavUtils.to(const DatabasePageDemo());
      },
    );
  }
}
