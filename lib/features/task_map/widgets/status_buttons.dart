import 'package:courier_app/api/model/task_map/buttons.dart';
import 'package:courier_app/features/task_map/providers/task_map_provider.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusButtons extends ConsumerStatefulWidget {
  final VoidCallback handleReDraw;
  final VoidCallback handleConfirm;
  final VoidCallback handleRemoveAll;

  const StatusButtons({
    super.key, 
    required this.handleReDraw,
    required this.handleConfirm,
    required this.handleRemoveAll,
  });

  @override
  ConsumerState<StatusButtons> createState() => _StatusButtonsState();
}

class _StatusButtonsState extends ConsumerState<StatusButtons> {
  @override
  Widget build(BuildContext context) {
    /// Get buttons 
    List<TaskMapButton> buttons = mapButtons1;

    /// 地图场景状态 
    MapStatusEnum mapStatus = ref.watch(mapStatusProvider);

    switch (mapStatus) {
      case MapStatusEnum.initial:
        buttons = mapButtons1;
        break;
      case MapStatusEnum.draw:
        buttons = mapButtons2;
        break;
      case MapStatusEnum.redraw:
        buttons = mapButtons3;
        break;
      case MapStatusEnum.complete:
        buttons = mapButtons4;
        break;
      default:
        buttons = mapButtons1;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          for (TaskMapButton item in buttons)
            Container(
              width: 104.0,
              height: 44.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              margin: item.paddingable ? const EdgeInsets.only(right: 12) : null,
              child: InkWell(
                onTap: () {
                  /// 点击画圈
                  if (item.type == "Draw") {
                    ref.read(mapStatusProvider.notifier).state = MapStatusEnum.draw;
                  }

                  /// 取消
                  if (item.type == "Cancel") {
                    if (mapStatus == MapStatusEnum.initial) {
                      ref.read(mapButtonsVisbleProvider.notifier).state = false;
                      widget.handleRemoveAll.call();
                    } 

                    if (mapStatus == MapStatusEnum.draw || mapStatus == MapStatusEnum.redraw) {
                      ref.read(mapStatusProvider.notifier).state = MapStatusEnum.initial;
                    } 

                    if (mapStatus == MapStatusEnum.redraw) {
                      ref.read(mapStatusProvider.notifier).state = MapStatusEnum.initial;
                      widget.handleReDraw.call();
                    } 
                  }

                  /// 重画
                  if (item.type == "Redraw" && !item.disable) {
                    ref.read(mapStatusProvider.notifier).state = MapStatusEnum.draw;
                    widget.handleReDraw.call();
                  }

                  /// 确认
                  if (item.type == "Confirm" && !item.disable) {
                    ref.read(mapStatusProvider.notifier).state = MapStatusEnum.complete;
                    widget.handleConfirm.call();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image:AssetImage(item.iconName),fit: BoxFit.fill),
                    const SizedBox(width: 9),
                    Texts.normalSemiBold(
                      item.type,
                      color: item.disable ? Colours.greyCC : Colours.primaryTextColor
                    )
                  ],
                )
              ),
            ),  
        ],
      ),
    );
  }  
}