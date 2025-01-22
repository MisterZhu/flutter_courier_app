import 'package:courier_app/features/task_map/providers/task_map_provider.dart';
import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HandleButtons extends ConsumerStatefulWidget {
  final VoidCallback getCurrentLocation;
  const HandleButtons({super.key, required this.getCurrentLocation,});

  @override
  ConsumerState<HandleButtons> createState() => _HandleButtonsState();
}

class _HandleButtonsState extends ConsumerState<HandleButtons> {
  @override
  Widget build(BuildContext context) {
    final positionOnStatus = ref.watch(mapPositionStatusProvider);

    return Container(
      width: 60.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              /// 定位按钮 
              widget.getCurrentLocation.call();

              ref.read(mapPositionStatusProvider.notifier).state = true;
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 22.0),
              child: Image(image:AssetImage(positionOnStatus ? Res.map_position_on: Res.map_position),fit: BoxFit.fill),
            )
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 15), child: Container(width: 44.0, height: 1.0, color: Colours.divider,),),
          InkWell(
            onTap: () {
              ref.read(mapButtonsVisbleProvider.notifier).state = true;
            },
            child: const Padding(
              padding: EdgeInsets.only(bottom: 22.0),
              child: Image(image:AssetImage(Res.map_draw),fit: BoxFit.fill),
            )
          ),
        ],
      )
    );
  }  
}