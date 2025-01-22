import 'package:courier_app/db/database_dao_base.dart';
import 'package:flutter/cupertino.dart';

class DatabaseDaoDemo extends DatabaseDaoBase {
  static final DatabaseDaoDemo _instance = DatabaseDaoDemo._();
  static DatabaseDaoDemo get instance => _instance;
  DatabaseDaoDemo._();

  @override
  String tableName = "database_table_demo";

  // 建表函数,当数据库中没有这个表时,基类会触发这个函数
  @override
  onCreate(db, version) async {
    debugPrint("创建 $tableName 数据表");
    await db.execute("""
      CREATE TABLE $tableName (
        id integer primary key autoincrement,
        sort integer,
        name TEXT,
        description TEXT
      )
    """);
  }

  // 当数据库升级时,基类会触发的函数
  @override
  onUpgrade(db, oldVersion, newVersion) {
    debugPrint('onUpgrade -> oldVersion: $oldVersion, newVersion: $newVersion');
  }

  // 当数据库降级,基类会触发的函数
  @override
  onDowngrade(db, oldVersion, newVersion) {
    debugPrint(
        'onDowngrade -> oldVersion: $oldVersion, newVersion: $newVersion');
  }
}
