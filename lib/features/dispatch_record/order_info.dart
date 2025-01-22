import 'dart:math';

import 'package:flutter/material.dart';

import '../../../widgets/base/texts.dart';
import '../../../widgets/dashed_border/dashed_border.dart';
import '../../res/colours.dart';

class OrderInfo extends StatelessWidget {
  final VoidCallback handleTap;

  const OrderInfo({super.key, required this.handleTap});

  Widget _renderStatus() {
    Random random = Random();

    // 生成随机数，范围是 0 到 1
    int randomNumber = random.nextInt(2);

    if (randomNumber > 0) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colours.quotationAlertTextColor,
        ),
        child: Center(
          child: Texts.small("Not Inbound", color: Colors.white, letterSpacing: 0,),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colours.taskRedColor,
      ),
      child: Center(
        child: Texts.small("Lost", color: Colors.white, letterSpacing: 0,),
      ),
    );
  }

  Widget _renderList(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Texts.normal(
          title,
          color: Colours.titleColor,
          letterSpacing: 0,
        ),
        Texts.normal(
          content,
          color: Colours.titleColor,
          letterSpacing: 0,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: handleTap,
        child: Container(
          padding: const EdgeInsets.only(top: 14),
          height: 134,
          width: 315,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Texts.normal(
                        "BUFZA1234567",
                        color: Colours.titleColor,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      _renderStatus(),
                    ],
                  ),
                  Texts.normal(
                    "2024-11-13 14:29",
                    color: Colours.grey63,
                    letterSpacing: 0,
                  ),
                ],
              ),
              _renderList("Postcode：", "4103"),
              _renderList("Suburb：", "CENTRAL"),
              _renderList("Area：", "Benoni Central(南非仓-ZA WH)"),
              const DashedBorder(),
            ],
          ),
        ),
      ),
    );
  }
}
