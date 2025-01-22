
import 'package:courier_app/api/model/task_map/buttons.dart';
import 'package:courier_app/res.dart';
import 'package:riverpod/riverpod.dart';

enum MapStatusEnum {
  // 初始化 展示cancel draw
  initial,
  // 画图 展示cancel redraw(disable) confirm(disable)
  draw,
  // 重新画图 展示cancel redraw(disable) confirm(disable)
  redraw,
  // 画图完成 展示cancel redraw confirm
  complete,
  // 确认完成 展示draw 选择起始点
  confirm
}

final mapButtonsVisbleProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final mapPositionStatusProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final buttonsProvider = StateProvider.autoDispose<List<TaskMapButton>>((ref) {
  return mapButtons1;
});

final mapStatusProvider = StateProvider.autoDispose<MapStatusEnum>((ref) {
  return MapStatusEnum.initial;
});

final mapButtons1 = [
  TaskMapButton(type: "Cancel", disable: false, iconName: Res.map_cancel, paddingable: true),
  TaskMapButton(type: "Draw", disable: false, iconName: Res.map_draw_min, paddingable: false)
];

final mapButtons2 = [
  TaskMapButton(type: "Cancel", disable: false, iconName: Res.map_cancel, paddingable: true),
  TaskMapButton(type: "Redraw", disable: true, iconName: Res.map_redraw_disable, paddingable: true),
  TaskMapButton(type: "Confirm", disable: true, iconName: Res.map_check_disable, paddingable: false),
];

final mapButtons3 = [
  TaskMapButton(type: "Cancel", disable: false, iconName: Res.map_cancel, paddingable: true),
  TaskMapButton(type: "Redraw", disable: false, iconName: Res.map_redraw, paddingable: true),
  TaskMapButton(type: "Confirm", disable: false, iconName: Res.map_check, paddingable: false),
];

final mapButtons4 = [
  TaskMapButton(type: "Draw", disable: false, iconName: Res.map_draw_min, paddingable: false)
];