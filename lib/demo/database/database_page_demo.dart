import 'dart:developer';
import 'dart:math' as math;

import 'package:courier_app/demo/database/database_dao_demo.dart';
import 'package:courier_app/demo/database/database_enyity_demo.dart';
import 'package:flutter/material.dart';

class DatabasePageDemo extends StatefulWidget {
  const DatabasePageDemo({super.key});

  @override
  State<DatabasePageDemo> createState() => _DatabasePageDemoState();
}

class _DatabasePageDemoState extends State<DatabasePageDemo> {
  late DatabaseDaoDemo _dbDao;
  List<DatabaseEntityDemo> _dataList = [];

  @override
  void initState() {
    super.initState();
    _dbDao = DatabaseDaoDemo.instance;
    _initDbData();
  }

  @override
  void dispose() {
    // 关闭数据库
    _dbDao.closeDatabase();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Database viewer'),
      ),
      body: _renderPageContent(),
    );
  }

  Widget _renderPageContent() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, top: 15, right: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: _fetchTableData, child: const Text('查看表数据')),
                  TextButton(
                      onPressed: _deleteTableData, child: const Text('删除表数据')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: _addData, child: const Text('插入数据')),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ReorderableListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      DatabaseEntityDemo item = _dataList[index];
                      return ListTile(
                        key: ValueKey('LIST_TILE$index'),
                        title: Text('Id ${item.id}'),
                        subtitle: Text(
                            'Name: ${item.name}\nDescription: ${item.description}'),
                        trailing: TextButton(
                          child: const Text('delete'),
                          onPressed: () {
                            _handleDelete(index);
                          },
                        ),
                      );
                    },
                    itemCount: _dataList.length,
                    onReorder: (int oldIndex, int newIndex) {
                      _handleExchange(oldIndex, newIndex);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _initDbData() {
    // 获取数据
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_dbDao.exists) {
        // 删除表数据
        _dbDao.dropTableData();
        // 初始化数据
        List<Map<String, dynamic>> mapValues = [];
        for (int i = 0; i < 30; i++) {
          mapValues.add({
            'sort': i,
            'name': _getRandomName(),
            'description': _getRandomDescription(),
          });
        }
        _dbDao.batchInsert(mapValues);
        // 查询数据
        _fetchTableData();
      }
    });
  }

  void _handleDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('删除提示'),
          content: const Text('是否删除此条数据?'),
          actions: <Widget>[
            TextButton(
              child: const Text('确定'),
              onPressed: () {
                DatabaseEntityDemo item = _dataList[index];
                _deleteData(item.id);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('关闭'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _handleExchange(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      // 更改UI数据
      final DatabaseEntityDemo item = _dataList.removeAt(oldIndex);
      _dataList.insert(newIndex, item);
      // 更新数据库
      _updateMultiData();
    });
  }

  // 随机一个名称
  String _getRandomName() {
    return (math.Random().nextInt(100 - 0 + 1) + 0).toString();
  }

  // 随机一个描述
  String _getRandomDescription() {
    return (math.Random().nextInt(200 - 100 + 1) + 100).toString();
  }

  // 查询表数据
  void _fetchTableData() async {
    try {
      final data = await _dbDao.query(orderBy: 'sort');
      debugPrint('item 表中的数据: $data');
      _dataList = List.generate(data.length, (i) {
        return DatabaseEntityDemo(
          id: data[i]['id'],
          sort: data[i]['sort'],
          name: data[i]['name'],
          description: data[i]['description'],
        );
      });
      setState(() {});
    } catch (error) {
      debugPrint('find error: $error');
    }
  }

  // 删除表数据
  void _deleteTableData() async {
    await _dbDao.dropTableData();
    _fetchTableData();
  }

  // 新增数据
  void _addData() async {
    await _dbDao.insert({
      'name': _getRandomName(),
      'description': _getRandomDescription(),
      'sort': 0,
    });
    _fetchTableData();
  }

  // 删除数据
  void _deleteData(id) async {
    await _dbDao.delete('id', id);
    _fetchTableData();
  }

  // 批量更新数据
  void _updateMultiData() async {
    // 重新编排数组内元素的sort值
    List<int> ids = [];
    List<Map<String, dynamic>> newDataList = [];
    for (int i = 0; i < _dataList.length; i++) {
      DatabaseEntityDemo entityDemo = _dataList[i];
      entityDemo.sort = i;
      ids.add(entityDemo.id);
      newDataList.add(entityDemo.toJson());
    }
    log('ids: $ids, newDataList: ${newDataList.toString()}');
    //  执行批量更新
    await _dbDao.batchUpdate('id', ids, newDataList);
    // 重新请求数据
    _fetchTableData();
  }
}
