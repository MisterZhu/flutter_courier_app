import 'package:flutter/material.dart';

import '../../../res/colours.dart';
import '../../../widgets/base/texts.dart';

class CardWidget extends StatelessWidget {
  final String title;

  final int num;

  const CardWidget({super.key, required this.title, required this.num});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 84,
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Texts.normal(
              title,
              color: Colours.grey63,
              letterSpacing: 0,
            ),
            Texts.largest(
              num.toString(),
              color: Colours.titleColor,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
            ),
          ],
        ),
      ),
    );
  }
}
