import 'package:courier_app/api/task_api.dart';
import 'package:courier_app/features/task/utils/task_utils.dart';
import 'package:courier_app/utils/dialog_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/model/task/paged_task_list.dart';
import '../../api/model/task/task.dart';
import '../../res/colours.dart';
import '../../res/dimens.dart';
import '../../utils/nav_utils.dart';
import '../../widgets/base/texts.dart';
import '../../widgets/count_down_timer/count_down_timer.dart';
import '../../widgets/slide_button/slide_button_view.dart';

class TaskAssigningPage extends ConsumerStatefulWidget {
  const TaskAssigningPage({super.key});

  @override
  ConsumerState<TaskAssigningPage> createState() => _TaskAssigningPageState();
}

class _TaskAssigningPageState extends ConsumerState<TaskAssigningPage> {
  bool _refresh = true;
  Future<void> _refreshTask() async {
    ref.invalidate(TaskUtils.getProviderByType(TaskType.assigning));
    _refresh = true;
  }

  late List<Task> data = [];

  final List<GlobalKey<SlideButtonState>> _listKey = [];

  final double _buttonWidth = 70;

  @override
  Widget build(BuildContext context) {
    if (_refresh) {
      initData();
    }
    return Column(
      children: [
        Expanded(child: _renderPageContent()),
        Visibility(visible: data.isNotEmpty, child: _allRefuseButton())
      ],
    );
  }

  Widget _renderPageContent() {
    return RefreshIndicator(
      onRefresh: _refreshTask,
      child: Column(
        children: [
          _headerView(),
          data.isEmpty
              ? Container()
              : ReorderableListView(
                  children: _listView(),
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final Task item = data.removeAt(oldIndex);
                      data.insert(newIndex, item);
                      _refresh = false;
                    });
                  },
                  proxyDecorator: (Widget child, int index, isDragging) {
                    return child; // 不对child进行任何装饰，即去掉拖拽时的背景高亮
                  },
                )
        ],
      ),
    );
  }

  Widget _headerView() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
        child: Row(
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: Dimens.borderRadius8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Texts.norma('Task', color: Colours.grey63),
                  const SizedBox(height: 12),
                  Texts.largestSemiBold(
                      TaskUtils.getCount(data, TaskType.assigning.value)
                          .toString(),
                      color: Colours.titleColor)
                ],
              ),
            )),
            const SizedBox(width: 15),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white, borderRadius: Dimens.borderRadius8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Texts.norma('Orders', color: Colours.grey63),
                  const SizedBox(height: 12),
                  Texts.largestSemiBold(
                      TaskUtils.getPackagesCount(data, TaskType.assigning.value)
                          .toString(),
                      color: Colours.titleColor)
                ],
              ),
            )),
          ],
        ));
  }

  List<Widget> _listView() {
    _listKey.clear();
    List<Widget> widget = [];
    for (int i = 0; i < data.length; i++) {
      widget.add(_itemWidget(i));
    }
    return widget;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _itemWidget(int index) {
    Task task = data[index];
    Color levelColor = TaskUtils.getLevelColor(task.tasktype?.toInt() ?? -1);

    // 普通
    var key = GlobalKey<SlideButtonState>();
    _listKey.add(key);

    return Container(
        key: ValueKey(index),
        margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
        child: Stack(
          children: [
            ClipRect(
              child: SlideButton(
                onSlideStarted: () {
                  for (var element in _listKey) {
                    if (element != key) {
                      element.currentState?.close();
                    }
                  }
                },
                key: key,
                buttons: <Widget>[..._menuButton(task, key)],
                singleButtonWidth: _buttonWidth,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: Dimens.borderRadius8),
                    child: _itemContent(task, levelColor),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  List<Widget> _menuButton(Task task, GlobalKey<SlideButtonState> key) {
    //15分钟内可以接受，超过自动接受
    int time = int.tryParse(task.datas?.lefttime ?? '') ?? 0;
    return time > 900000
        ? [
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.all(0.5),
                decoration: const BoxDecoration(
                    color: Colours.taskRedColor,
                    borderRadius: Dimens.rightBorderRadius8),
                width: _buttonWidth,
                child: Center(
                  child: Texts.normal('Refuse', color: Colors.white),
                ),
              ),
              onTap: () {
                key.currentState?.close();
              },
            )
          ]
        : [
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 0.5),
                decoration: const BoxDecoration(color: Colours.taskRedColor),
                width: _buttonWidth,
                child: Center(
                  child: Texts.normal('Refuse', color: Colors.white),
                ),
              ),
              onTap: () {
                key.currentState?.close();
              },
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 0.5),
                decoration: const BoxDecoration(
                    color: Colours.taskBussiness1,
                    borderRadius: Dimens.rightBorderRadius8),
                width: _buttonWidth,
                child: Center(
                  child: Texts.normal('Accept', color: Colors.white),
                ),
              ),
              onTap: () {
                key.currentState?.close();
              },
            )
          ];
  }

  Widget _allRefuseButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
      child: GestureDetector(
        onTap: () {
          DialogUtils.showDialog(
              content: 'Are you sure all refuse？',
              positiveText: 'Confirm',
              negativeText: 'Cancel');
        },
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
              color: Colours.taskRedColor,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          alignment: Alignment.center,
          child: Texts.larger('All Refuse', color: Colors.white),
        ),
      ),
    );
  }

  Column _itemContent(Task task, Color levelColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Texts.largeSemiBold(
                task.tasktype == TaskType.pick_up.value
                    ? task.receiver!
                    : task.id.toString(),
                color: Colours.taskTitleColor),
            const SizedBox(width: 6),
            task.datas?.lefttime != null
                ? CountDownTimer(
                    totalMilliseconds:
                        int.tryParse(task.datas?.lefttime ?? '') ?? 0,
                    onFinish: () {},
                  )
                : Container(),
            const Expanded(child: SizedBox()),
            Container(
              width: 25,
              height: 19,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: levelColor,
                  borderRadius: task.tasktype == TaskType.dispatch.value
                      ? Dimens.borderRadius4
                      : Dimens.leftBorderRadius4),
              child:
                  Texts.small(task.datas?.typestr ?? '', color: Colors.white),
            ),
            ((task.tasktype == TaskType.pick_up.value ||
                        task.tasktype == TaskType.assigning.value) &&
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
      ],
    );
  }

  void initData() {
    AsyncValue<PagedTaskList<Task>> task = ref.watch(
        TaskUtils.getProviderByType(TaskType.assigning)
            as ProviderListenable<AsyncValue<PagedTaskList<Task>>>);
    if (task.value != null) {
      data = List<Task>.from(task.value!.tasks);
      for (var task in data) {
        task.db_table_task_new = false;
      }
    }
  }
}
