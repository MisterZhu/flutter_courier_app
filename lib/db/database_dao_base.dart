import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseDaoBase {
  static const String _dbName = "courier_app_db"; // 数据库名称
  static const int _newVersion = 1; // 数据库版本
  static int _oldVersion = 0; // 数据库上一个版本
  static String? _dbBasePath; // 数据库地址
  static Database? _database; // 数据库实例

  abstract String tableName; // 数据表名称,在子类中必须要重写的字段
  bool exists = false; // 数据表是否存在

  // 建表函数, 在子类中必须重写
  Future<void> onCreate(Database db, int version);

  // 数据库实例化完成
  onReload(Database db, int version) {}

  // 数据库升级时触发的函数, 子类中可以根据需要时进行重写
  onUpgrade(Database db, int oldVersion, int newVersion) {}

  // 数据库降级触发的函数, 子类中可以根据需要时进行重写
  onDowngrade(Database db, int oldVersion, int newVersion) {}

  // 初始化方法
  DatabaseDaoBase() {
    _initDatabase();
  }

  // 数据库对象
  Database get database => _database!;

  // 初始化数据库
  Future<Database> _initDatabase() async {
    // 获取数据库的位置
    _dbBasePath ??= "${await getDatabasesPath()}/$_dbName.db";
    debugPrint('database path: $_dbBasePath');
    // 打开数据库
    _database ??= await openDatabase(
      _dbBasePath!,
      version: _newVersion,
      // 数据库初始化时触发的回调
      // onConfigure: (db) {},
      // 数据库被打开时触发的回调
      // onOpen: (db) {},
      // 创建数据库时触发的回调
      // onCreate: onCreate,
      // 数据库升级时触发的回调
      onUpgrade: (db, old, newV) {
        _oldVersion = old;
      },
      // 数据库降级时触发的回调
      onDowngrade: (db, old, newV) {
        _oldVersion = old;
      },
    );

    // 数据库实例化完成
    onReload(_database!, _newVersion);

    // 判断表是否存在
    exists = await tableExists();
    if (!exists) {
      // 表不存再时调用建表函数
      await onCreate(_database!, _newVersion);
      exists = true;
    }

    debugPrint("_oldVersion === $_oldVersion");
    debugPrint("_newVersion === $_newVersion");
    // 数据第一次创建时_oldVersion等于0, 所以忽略
    if (_oldVersion != 0) {
      // 判断是否降级了
      if (_oldVersion > _newVersion) {
        // 数据库降级了, 如果子类重写了onDowngrade方法, 则调用的是子类的;
        await onDowngrade(
          _database!,
          await _database!.getVersion(),
          _newVersion,
        );
      } else
      // 判断是否升级了
      if (_oldVersion < _newVersion) {
        // 数据库升级了,如果子类重写了onUpgrade方法, 则调用的是子类的;
        await onUpgrade(
          _database!,
          _oldVersion,
          _newVersion,
        );
      }
    }

    return _database!;
  }

  // 关闭数据库
  Future closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  /// ****** sqlite_master ******
  /// 每一个 SQLite 数据库都有一个叫 sqlite_master 的表，该表会自动创建
  /// sqlite_master是一个特殊表, 存储数据库的元信息, 如表(table), 索引(index), 视图(view), 触发器(trigger), 可通过select查询相关信息

  // 表是否存在
  Future<bool> tableExists() async {
    if (_database == null) {
      await _initDatabase();
    }

    var res = await _database!.rawQuery(
      """
      SELECT * FROM sqlite_master WHERE TYPE = 'table' AND NAME = '$tableName'
      """,
    );
    return res.isNotEmpty;
  }

  // 删除表
  Future<void> dropTable() async {
    if (_database == null) {
      await _initDatabase();
    }

    await _database!.execute("""
      drop table if exists $tableName;
    """);
  }

  // 删除表数据
  Future<void> dropTableData() async {
    if (_database == null) {
      await _initDatabase();
    }

    // 删除表中所有的数据，但是表的结构会保持不变
    await _database!.execute("""
      DELETE FROM $tableName
    """);
  }

  // 表中的列是否存在
  Future<bool> columnExists(String columnName) async {
    if (_database == null) {
      await _initDatabase();
    }

    var result = await _database!.rawQuery("""
      SELECT sql FROM sqlite_master WHERE type='table' AND name='$tableName' COLLATE NOCASE limit 1
    """);
    String sql = result[0]["sql"] as String;
    int startIndex = sql.indexOf("(") + 1;
    int endIndex = sql.indexOf(")");
    sql = sql.substring(startIndex, endIndex);

    List<String> sqlList = sql.split(",").map((e) => e.trim()).toList();
    bool colExists = false;
    for (int j = 0; j < sqlList.length; j++) {
      var rowStr = sqlList[j].trim().split(",").join("");
      var colName = rowStr.split(" ")[0].trim();
      if (colName == columnName) {
        colExists = true;
        break;
      }
    }
    return colExists;
  }

  // 新增表中的列
  Future addColumn(String columnName, String type) async {
    if (_database == null) {
      await _initDatabase();
    }

    return await _database!.rawQuery("""
      ALTER TABLE $tableName ADD  $columnName $type
    """);
  }

  // 插入数据
  Future<int> insert(Map<String, dynamic> mapValue) async {
    if (_database == null) {
      await _initDatabase();
    }

    return await _database!.insert(tableName, mapValue);
  }

  // 批量插入
  batchInsert(List<Map<String, dynamic>> mapValues) async {
    return await Future.wait(
      mapValues.map((mapValue) async => await insert(mapValue)).toList(),
    );
  }

  // 删除数据
  Future<int> delete(String key, dynamic value) async {
    if (_database == null) {
      await _initDatabase();
    }

    String whereSql =
        value.runtimeType == String ? "$key='$value'" : "$key=$value";

    return _database!.delete(
      tableName,
      where: whereSql,
    );
  }

  // 批量删除
  batchDelete(String key, List<dynamic> values) async {
    return await Future.wait(
      values.map((value) async => await delete(key, value)).toList(),
    );
  }

  // 修改数据
  Future<int> update(
      String key, dynamic value, Map<String, dynamic> mapValue) async {
    if (_database == null) {
      await _initDatabase();
    }

    String whereSql =
        value.runtimeType == String ? "$key='$value'" : "$key=$value";

    return _database!.update(
      tableName,
      mapValue,
      where: whereSql,
    );
  }

  // 批量修改数据
  batchUpdate(String key, List<dynamic> values,
      List<Map<String, dynamic>> mapValues) async {
    return await Future.wait(
      values.map((value) async {
        final findMapValues =
            mapValues.where((mapValue) => mapValue[key] == value).toList();
        return await update(key, value, findMapValues.first);
      }).toList(),
    );
  }

  // 查询数据 - 条件
  Future<List<Map<String, dynamic>>> query({
    Map<String, dynamic>? where,
    String? orderBy,
  }) async {
    if (_database == null) {
      await _initDatabase();
    }

    List<String> keys = where?.keys.toList() ?? [];
    List<String> whereList = [];
    for (int i = 0; i < keys.length; i++) {
      String key = keys[i];
      if (where![key].runtimeType == String) {
        whereList.add("$key='${where[key]}'");
      } else {
        whereList.add("$key=${where[key]}");
      }
    }

    String? whereSql = whereList.isEmpty ? null : whereList.join(" and ");

    return await _database!.query(
      tableName,
      where: whereSql,
      orderBy: orderBy,
    );
  }

  // 调用原始SQL
  Future<List<Map<String, dynamic>>> rawQuery(String sql) async {
    if (_database == null) {
      await _initDatabase();
    }

    debugPrint('Raw Query SQL: $sql');

    return _database!.rawQuery(sql);
  }

  // // 查询数据 - 条件 & 分页
  // Future<List<Map<String, dynamic>>> queryWithWhereAndPage({
  //   Map<String, dynamic>? where,
  //   int? page,
  //   int? pageSize,
  // }) async {
  //   if (_database == null) {
  //     await _initDatabase();
  //   }
  //
  //   List<String> keys = where?.keys.toList() ?? [];
  //   List<String> whereList = [];
  //   for (int i = 0; i < keys.length; i++) {
  //     String key = keys[i];
  //     if (where![key].runtimeType == String) {
  //       whereList.add("$key='${where[key]}'");
  //     } else {
  //       whereList.add("$key=${where[key]}");
  //     }
  //   }
  //
  //   String sql = whereList.join(" and ");
  //   String mapKey = "${tableName}_${sql}_page=${page}_pageSize=$pageSize";
  //
  //   List data = sql.isEmpty ? [] : (_findCache[mapKey] ?? []);
  //   if (data.isNotEmpty) {
  //     return _findCache[mapKey]!;
  //   }
  //
  //   var result = await _database!.query(
  //     tableName,
  //     where: sql.isEmpty ? null : sql,
  //     offset: page == null ? null : (page - 1) * (pageSize ?? 1),
  //     limit: pageSize,
  //   );
  //   if (sql.isNotEmpty) {
  //     _findCache[mapKey] = result;
  //   }
  //   return result;
  // }
  //
  // // 缓存的数据
  // static final Map<String, List<Map<String, dynamic>>> _findCache = {};
}
