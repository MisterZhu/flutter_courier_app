import 'package:courier_app/res/colours.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryCount extends ConsumerWidget {
  const SummaryCount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 64.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 15),
              Texts.normalBold(
                '80',
                color: Colors.black,
              ),
              const SizedBox(height: 6),
              Texts.small(
                'Delivery',
                color: Colours.grey63,
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Container(width: 44.0, height: 1.0, color: Colours.divider,),),
          Column(
            children: [
              Texts.normalBold(
                '80',
                color: Colors.black,
              ),
              const SizedBox(height: 6),
              Texts.small(
                'Pick up',
                color: Colours.grey63,
              ),
              const SizedBox(height: 15),
            ],
          )
        ],
      )
    );
  }  
}