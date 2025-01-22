import 'package:flutter/material.dart';

import '../../../res/colours.dart';
import '../../../widgets/base/texts.dart';

class OrderManagementItem extends StatelessWidget {
  final String title;

  final num amount;

  final VoidCallback onClick;

  const OrderManagementItem(
      {super.key,
      required this.title,
      required this.amount,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClick,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Texts.large(
              amount.toString(),
              letterSpacing: 0,
              color: Colours.numColor,
              fontWeight: FontWeight.w900,
              textAlign: TextAlign.center,
            ),
            Texts.norma(
              title,
              letterSpacing: 0,
              color: Colours.numColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
