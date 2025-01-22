import 'dart:convert';

import 'package:courier_app/api/task_api.dart';
import 'package:courier_app/db/daos/task_dao.dart';
import 'package:courier_app/features/task/providers/task_providers.dart';
import 'package:courier_app/features/task/utils/task_utils.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/model/task/paged_task_list.dart';
import '../../api/model/task/task.dart';
import '../../utils/nav_utils.dart';
import '../../widgets/base/texts.dart';
import '../../widgets/diagonal_clipper/diagonal_clipper.dart';
import '../../widgets/slide_button/slide_button_view.dart';
import '../dispatch_detail/dispatch_detail_page.dart';
import '../pick_up_deatil/pick_up_detail_page.dart';

class TaskChildPage extends ConsumerStatefulWidget {
  final TaskType type;
  const TaskChildPage({super.key, required this.type});

  @override
  ConsumerState<TaskChildPage> createState() => _TaskChildPageState();
}

class _TaskChildPageState extends ConsumerState<TaskChildPage>
    with SingleTickerProviderStateMixin {
  bool _refresh = true;
  Future<void> _refreshTask() async {
    ref.invalidate(TaskUtils.getProviderByType(widget.type));
    _refresh = true;
  }

  late TaskDao _dbTaskDao;
  late List<Task> _taskList = [];
  late List<Task> _dbTaskList = [];
  late List<Task> _newTaskList = [];

  final List<GlobalKey<SlideButtonState>> _listKey = [];

  @override
  Widget build(BuildContext context) {
    if (_refresh) {
      initData();
    }
    return _renderPageContent();
  }

  Widget _renderPageContent() {
    return RefreshIndicator(
      onRefresh: _refreshTask,
      child: _taskList.isEmpty
          ? Container()
          : ReorderableListView(
              children: _listView(),
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final Task item = _taskList.removeAt(oldIndex);
                  item.db_table_task_new = false;
                  item.db_table_task_sort = newIndex;
                  _taskList.insert(newIndex, item);
                  _updateDbData(item, newIndex);
                  _refresh = false;
                });
              },
              proxyDecorator: (Widget child, int index, isDragging) {
                return child; // 不对child进行任何装饰，即去掉拖拽时的背景高亮
              },
            ),
    );
  }

  List<Widget> _listView() {
    _listKey.clear();
    List<Widget> widget = [];
    for (int i = 0; i < _taskList.length; i++) {
      widget.add(_itemWidget(i));
    }
    return widget;
  }

  @override
  void initState() {
    _dbTaskDao = TaskDao.instance;
    super.initState();
  }

  @override
  void dispose() {
    _dbTaskDao.closeDatabase();
    super.dispose();
  }

  Widget _itemWidget(int index) {
    Task task = _taskList[index];
    Color levelColor = TaskUtils.getLevelColor(task.tasktype?.toInt() ?? -1);

    List<Color> labelColors = _labelTextColor(
        TaskUtils.getLabelText(task.customertype?.toInt() ?? 0));

    // Color tipsColor = task['tip'] == ''
    //     ? Colors.transparent
    //     : (task['tip'] == 'NEW'
    //         ? Colours.taskOrangeColor
    //         : Colours.taskRedColor);
    Color tipsColor = Colors.transparent;
    if (task.db_table_task_new!) {
      tipsColor = Colours.taskOrangeColor;
    } else {
      if (task.color != null) {
        tipsColor = Colours.taskRedColor;
      } else {
        tipsColor = Colors.transparent;
      }
    }
    Color lineBorderColor = _lineBorderColor(task);

    // 普通
    var key = GlobalKey<SlideButtonState>();
    _listKey.add(key);

    return Container(
        key: ValueKey(index),
        margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
        child: Stack(
          children: [
            ClipRect(
              child: task.tasktype == TaskType.dispatch.value
                  ? _itemContent(task, levelColor, labelColors)
                  : _itemContentHasSlideButton(
                      key, task, levelColor, labelColors),
            ),
            _itemLineBorder(lineBorderColor),
            _positionedTipWidget(task, tipsColor),
            _positionedTipText(task)
          ],
        ));
  }

  Color _lineBorderColor(Task bean) {
    Color lineBorderColor;
    if (bean.tasktype == TaskType.dispatch.value) {
      if (bean.db_table_task_new!) {
        lineBorderColor = Colours.taskOrangeColor;
      } else {
        if (bean.color != null) {
          lineBorderColor = Colours.taskRedColor;
        } else {
          lineBorderColor = Colors.transparent;
        }
      }
    } else if (bean.tasktype == TaskType.pick_up.value) {
      lineBorderColor = Colours.taskOrangeColor;
    } else {
      lineBorderColor = Colors.transparent;
    }
    return lineBorderColor;
  }

  SlideButton _itemContentHasSlideButton(GlobalKey<SlideButtonState> key,
      Task bean, Color levelColor, List<Color> labelColors) {
    return SlideButton(
      onSlideStarted: () {
        for (var element in _listKey) {
          if (element != key) {
            element.currentState?.close();
          }
        }
      },
      key: key,
      buttons: <Widget>[
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 0.5),
            decoration: const BoxDecoration(
                color: Colours.taskRedColor,
                borderRadius: Dimens.rightBorderRadius8),
            width: 70,
            child: Center(
              child: Texts.normal('Refuse', color: Colors.white),
            ),
          ),
          onTap: () {
            key.currentState?.close();
          },
        )
      ],
      singleButtonWidth: 70,
      child: _itemContent(bean, levelColor, labelColors),
    );
  }

  Container _itemContent(Task task, Color levelColor, List<Color> labelColors) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Colors.white, borderRadius: Dimens.borderRadius8),
      child: GestureDetector(
        onTap: () {
          if (task.tasktype == TaskType.dispatch.value) {
            NavUtils.to(DispatchDetailPage(taskData: task));
          } else if (task.tasktype == TaskType.pick_up.value) {
            NavUtils.to(const PickUpDetailPage());
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Texts.largeSemiBold(
                      task.tasktype == TaskType.pick_up.value
                          ? task.receiver!
                          : task.id.toString(),
                      color: Colours.taskTitleColor),
                ),
                Container(
                  width: 25,
                  height: 19,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: levelColor,
                      borderRadius: task.tasktype == TaskType.dispatch.value
                          ? Dimens.borderRadius4
                          : Dimens.leftBorderRadius4),
                  child: Texts.small(task.datas?.typestr ?? '',
                      color: Colors.white),
                ),
                ((task.tasktype == TaskType.pick_up.value) &&
                        task.packages != null)
                    ? Container(
                        width: 25,
                        height: 19,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colours.taskBussiness2,
                            border: Border.all(color: levelColor),
                            borderRadius: Dimens.rightBorderRadius4),
                        child: Texts.small(
                          task.packages.toString(),
                          color: levelColor,
                        ),
                      )
                    : Container()
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            Row(
              children: [
                Expanded(
                    child: Texts.normal(
                  task.receiveraddress ?? task.receiveraddress2 ?? '',
                  color: Colours.grey63,
                )),
                const SizedBox(
                  height: 12,
                ),
                const Icon(Icons.menu)
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            TaskUtils.isShowLabel(task.customertype?.toInt() ?? 0)
                ? Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: labelColors[1],
                        border: Border.all(color: labelColors[0], width: 0.5),
                        borderRadius: Dimens.borderRadius2),
                    child: Texts.small(
                      TaskUtils.getLabelText(task.customertype?.toInt() ?? 0),
                      color: labelColors[0],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Positioned _positionedTipText(Task bean) {
    return Positioned(
      top: 6,
      left: 3,
      child: Transform.rotate(
        angle: -0.8,
        child: Texts.smallest1(
          bean.datas?.typestr ?? '',
          color: Colors.white,
        ),
      ),
    );
  }

  Positioned _positionedTipWidget(Task bean, Color tipsColor) {
    return Positioned(
      top: 0,
      left: 0,
      child: (bean.db_table_task_new! || bean.color != null)
          ? Container()
          : _tipWidget(tipsColor),
    );
  }

  Positioned _itemLineBorder(Color tipsColor) {
    return Positioned(
        top: 0,
        left: 0,
        bottom: 0,
        right: 0,
        child: IgnorePointer(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: tipsColor, width: 1),
                borderRadius: Dimens.borderRadius8),
          ),
        ));
  }

  List<Color> _labelTextColor(String label) {
    late List<Color> color = [const Color(0xFF007AFF), const Color(0x1A007AFF)];
    switch (label) {
      case 'Takealot':
        color = [Colours.taskTakealot1, Colours.taskTakealot2];
        break;

      case 'Bussiness':
        color = [Colours.taskBussiness1, Colours.taskBussiness2];
        break;

      case 'Heavy Freight':
        color = [Colours.taskHeavyFreight1, Colours.taskHeavyFreight2];
        break;
    }

    return color;
  }

  Widget _tipWidget(Color color) {
    return ClipPath(
      clipper: DiagonalClipper(),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8))),
        width: 40.0,
        height: 40.0,
      ),
    );
  }

  void initData() {
    if (_dbTaskDao.exists) {
      _dbTaskDao.dropTableData();
      _refreshData();
      _fetchTableData();
    } else {
      _refreshData();
      _batchInsertDbData(_taskList);
    }
  }

  // 查询表数据
  void _fetchTableData() async {
    try {
      final data = await _dbTaskDao.query(orderBy: 'db_table_task_sort');
      debugPrint('item 表中的数据: $data');
      _dbTaskList = List.generate(data.length, (i) {
        return Task(
          db_table_task_new: data[i]['db_table_task_new'],
          db_table_task_sort: data[i]['db_table_task_sort'],
          db_table_task_id: data[i]['db_table_task_id'],
          sendstatus: data[i]['sendstatus'],
          transitpackageid: data[i]['transitpackageid'],
          rwspackageid: data[i]['rwspackageid'],
          clientid: data[i]['clientid'],
          selfpickflg: data[i]['selfpickflg'],
          lostreason: data[i]['lostreason'],
          selfpickhubid: data[i]['selfpickhubid'],
          receivecityid: data[i]['receivecityid'],
          storehouseid: data[i]['storehouseid'],
          id: data[i]['id'],
          expressnumber: data[i]['expressnumber'],
          rtsstatus: data[i]['rtsstatus'],
          hubid: data[i]['hubid'],
          courierbillcollectid: data[i]['courierbillcollectid'],
          receiver: data[i]['receiver'],
          picktype: data[i]['picktype'],
          holdtype: data[i]['holdtype'],
          remoteareastatus: data[i]['remoteareastatus'],
          packages: data[i]['packages'],
          version: data[i]['version'],
          lockuserid: data[i]['lockuserid'],
          expresscompanyexpressnumber: data[i]['expresscompanyexpressnumber'],
          receivertelephone: data[i]['receivertelephone'],
          ordertype: data[i]['ordertype'],
          expressextendid: data[i]['expressextendid'],
          bookingdeliverytime: data[i]['bookingdeliverytime'],
          expressreceivetime: data[i]['expressreceivetime'],
          sendcompany: data[i]['sendcompany'],
          finishtime: data[i]['finishtime'],
          billid: data[i]['billid'],
          pickpin: data[i]['pickpin'],
          createuserid: data[i]['createuserid'],
          sendareaid: data[i]['sendareaid'],
          receiveraddress: data[i]['receiveraddress'],
          receiveaddress2: data[i]['receiveaddress2'],
          rwsreport: data[i]['rwsreport'],
          deliveryareaid: data[i]['deliveryareaid'],
          courierbillid: data[i]['courierbillid'],
          shelfid: data[i]['shelfid'],
          createtime: data[i]['createtime'],
          adminclientid: data[i]['adminclientid'],
          returndate: data[i]['returndate'],
          thirdnumber: data[i]['thirdnumber'],
          receivecity: data[i]['receivecity'],
          systemsignin: data[i]['systemsignin'],
          receivetelephone: data[i]['receivetelephone'],
          smallparcel: data[i]['smallparcel'],
          holdcheck: data[i]['holdcheck'],
          packagenumber: data[i]['packagenumber'],
          paystatus: data[i]['paystatus'],
          franchiseid: data[i]['franchiseid'],
          possiblelostflag: data[i]['possiblelostflag'],
          updatetime: data[i]['updatetime'],
          discardssign: data[i]['discardssign'],
          slottime: data[i]['slottime'],
          booking: data[i]['booking'],
          orderno: data[i]['orderno'],
          packageid: data[i]['packageid'],
          codmoney: data[i]['codmoney'],
          expresscompanyid: data[i]['expresscompanyid'],
          rwstrunklineno: data[i]['rwstrunklineno'],
          areaid: data[i]['areaid'],
          expresscostid: data[i]['expresscostid'],
          checkstatus: data[i]['checkstatus'],
          customertype: data[i]['customertype'],
          tasktype: data[i]['tasktype'],
          errorstatus: data[i]['errorstatus'],
          prepayflg: data[i]['prepayflg'],
          datas: TaskDatas.fromJsonString(data[i]['datas']),
          receivecountry: data[i]['receivecountry'],
          lostflg: data[i]['lostflg'],
          transportmode: data[i]['transportmode'],
          returntype: data[i]['returntype'],
          weight: data[i]['weight'],
          sort: data[i]['sort'],
          receivesuburb: data[i]['receivesuburb'],
          returnproblemflag: data[i]['returnproblemflag'],
          receivepostcode: data[i]['receivepostcode'],
          pickareaid: data[i]['pickareaid'],
          rwshubid: data[i]['rwshubid'],
          heavyfreightflg: data[i]['heavyfreightflg'],
          blnumber: data[i]['blnumber'],
          receiveraddress2: data[i]['receiveraddress2'],
          receivecoordinates: data[i]['receivecoordinates'],
          returnstatus: data[i]['returnstatus'],
          delaytime: data[i]['delaytime'],
          receiveaddress: data[i]['receiveaddress'],
          receiveemail: data[i]['receiveemail'],
          deliveryflag: data[i]['deliveryflag'],
          courierid: data[i]['courierid'],
          senderaddress: data[i]['senderaddress'],
          packageemergency: data[i]['packageemergency'],
          receivercoordinates: data[i]['receivercoordinates'],
          deliveryrfid: data[i]['deliveryrfid'],
          deliverabletime: data[i]['deliverabletime'],
          takealotdcid: data[i]['takealotdcid'],
          selfpicktime: data[i]['selfpicktime'],
          nextsiteid: data[i]['nextsiteid'],
          color: data[i]['color'],
        );
      });

      if (_taskList.isNotEmpty) {
        for (int i = _taskList.length - 1; i >= 0; i--) {
          Task task = _taskList[i];
          if (!_dbTaskList.contains(task)) {
            task.db_table_task_new = true;
            _newTaskList.insert(0, task);
          }
        }
        for (int i = 0; i < _newTaskList.length; i++) {
          Task task = _newTaskList[i];
          task.db_table_task_sort = i;
        }
        if (_newTaskList.isNotEmpty) {
          _batchInsertDbData(_newTaskList);
        }

        _dbTaskList.insertAll(0, _newTaskList);
        for (int i = 0; i < _dbTaskList.length; i++) {
          Task task = _dbTaskList[i];
          task.db_table_task_sort = i;
        }
      }

      _taskList = _dbTaskList;

      setState(() {});
    } catch (error) {
      debugPrint('find error: $error');
    }
  }

  void _batchInsertDbData(List<Task> _taskList) {
    List<Map<String, dynamic>> mapValues = [];
    for (int i = 0; i < _taskList.length; i++) {
      mapValues.add({
        'db_table_task_sort': i,
        'db_table_task_id': _taskList[i].db_table_task_id,
        'db_table_task_new': _taskList[i].db_table_task_new,
        'sendstatus': _taskList[i].sendstatus,
        'transitpackageid': _taskList[i].transitpackageid,
        'rwspackageid': _taskList[i].rwspackageid,
        'clientid': _taskList[i].clientid,
        'selfpickflg': _taskList[i].selfpickflg,
        'lostreason': _taskList[i].lostreason,
        'selfpickhubid': _taskList[i].selfpickhubid,
        'receivecityid': _taskList[i].receivecityid,
        'storehouseid': _taskList[i].storehouseid,
        'id': _taskList[i].id,
        'expressnumber': _taskList[i].expressnumber,
        'rtsstatus': _taskList[i].rtsstatus,
        'hubid': _taskList[i].hubid,
        'courierbillcollectid': _taskList[i].courierbillcollectid,
        'receiver': _taskList[i].receiver,
        'picktype': _taskList[i].picktype,
        'holdtype': _taskList[i].holdtype,
        'remoteareastatus': _taskList[i].remoteareastatus,
        'packages': _taskList[i].packages,
        'version': _taskList[i].version,
        'lockuserid': _taskList[i].lockuserid,
        'expresscompanyexpressnumber': _taskList[i].expresscompanyexpressnumber,
        'receivertelephone': _taskList[i].receivertelephone,
        'ordertype': _taskList[i].ordertype,
        'expressextendid': _taskList[i].expressextendid,
        'bookingdeliverytime': _taskList[i].bookingdeliverytime,
        'expressreceivetime': _taskList[i].expressreceivetime,
        'sendcompany': _taskList[i].sendcompany,
        'finishtime': _taskList[i].finishtime,
        'billid': _taskList[i].billid,
        'pickpin': _taskList[i].pickpin,
        'createuserid': _taskList[i].createuserid,
        'sendareaid': _taskList[i].sendareaid,
        'receiveraddress': _taskList[i].receiveraddress,
        'receiveaddress2': _taskList[i].receiveaddress2,
        'rwsreport': _taskList[i].rwsreport,
        'deliveryareaid': _taskList[i].deliveryareaid,
        'courierbillid': _taskList[i].courierbillid,
        'createtime': _taskList[i].createtime,
        'shelfid': _taskList[i].shelfid,
        'adminclientid': _taskList[i].adminclientid,
        'returndate': _taskList[i].returndate,
        'thirdnumber': _taskList[i].thirdnumber,
        'receivecity': _taskList[i].receivecity,
        'systemsignin': _taskList[i].systemsignin,
        'receivetelephone': _taskList[i].receivetelephone,
        'smallparcel': _taskList[i].smallparcel,
        'holdcheck': _taskList[i].holdcheck,
        'packagenumber': _taskList[i].packagenumber,
        'paystatus': _taskList[i].paystatus,
        'franchiseid': _taskList[i].franchiseid,
        'possiblelostflag': _taskList[i].possiblelostflag,
        'updatetime': _taskList[i].updatetime,
        'discardssign': _taskList[i].discardssign,
        'slottime': _taskList[i].slottime,
        'booking': _taskList[i].booking,
        'orderno': _taskList[i].orderno,
        'packageid': _taskList[i].packageid,
        'codmoney': _taskList[i].codmoney,
        'expresscompanyid': _taskList[i].expresscompanyid,
        'rwstrunklineno': _taskList[i].rwstrunklineno,
        'areaid': _taskList[i].areaid,
        'expresscostid': _taskList[i].expresscostid,
        'checkstatus': _taskList[i].checkstatus,
        'customertype': _taskList[i].customertype,
        'tasktype': _taskList[i].tasktype,
        'errorstatus': _taskList[i].errorstatus,
        'prepayflg': _taskList[i].prepayflg,
        'datas': jsonEncode(_taskList[i].datas),
        'receivecountry': _taskList[i].receivecountry,
        'lostflg': _taskList[i].lostflg,
        'transportmode': _taskList[i].transportmode,
        'returntype': _taskList[i].returntype,
        'weight': _taskList[i].weight,
        'sort': _taskList[i].sort,
        'receivesuburb': _taskList[i].receivesuburb,
        'returnproblemflag': _taskList[i].returnproblemflag,
        'receivepostcode': _taskList[i].receivepostcode,
        'pickareaid': _taskList[i].pickareaid,
        'rwshubid': _taskList[i].rwshubid,
        'heavyfreightflg': _taskList[i].heavyfreightflg,
        'blnumber': _taskList[i].blnumber,
        'receiveraddress2': _taskList[i].receiveraddress2,
        'receivecoordinates': _taskList[i].receivecoordinates,
        'returnstatus': _taskList[i].returnstatus,
        'delaytime': _taskList[i].delaytime,
        'receiveaddress': _taskList[i].receiveaddress,
        'receiveemail': _taskList[i].receiveemail,
        'deliveryflag': _taskList[i].deliveryflag,
        'courierid': _taskList[i].courierid,
        'senderaddress': _taskList[i].senderaddress,
        'packageemergency': _taskList[i].packageemergency,
        'receivercoordinates': _taskList[i].receivercoordinates,
        'deliveryrfid': _taskList[i].deliveryrfid,
        'deliverabletime': _taskList[i].deliverabletime,
        'takealotdcid': _taskList[i].takealotdcid,
        'selfpicktime': _taskList[i].selfpicktime,
        'nextsiteid': _taskList[i].nextsiteid,
        'color': _taskList[i].color,
      });
    }
    _dbTaskDao.batchInsert(mapValues);
  }

  void _updateDbData(Task task, int pos) {
    Map<String, dynamic> mapValue = {
      'db_table_task_sort': pos,
      'db_table_task_id': _taskList[pos].db_table_task_id,
    };
    _dbTaskDao.insert(mapValue);
  }

  void _refreshData() {
    AsyncValue<PagedTaskList<Task>> task = ref.watch(
        TaskUtils.getProviderByType(widget.type)
            as ProviderListenable<AsyncValue<PagedTaskList<Task>>>);
    if (task.value != null) {
      _taskList = List<Task>.from(task.value!.tasks);
      for (var task in _taskList) {
        task.db_table_task_new = false;
      }
    }
  }
}
