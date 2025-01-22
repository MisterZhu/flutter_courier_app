import 'dart:math';

import 'package:courier_app/res/colours.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/base/texts.dart';
import '../../../widgets/dashed_border/dashed_border.dart';

class DeliveryInfo extends StatelessWidget {
  final VoidCallback handleTap;

  const DeliveryInfo({super.key, required this.handleTap});

  Widget _renderStatus() {
    Random random = Random();

    // 生成随机数，范围是 0 到 1
    int randomNumber = random.nextInt(2);

    if (randomNumber > 0) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 7,
            width: 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.5),
              color: Colours.failColor,
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Texts.normal(
            "Delay",
            color: Colours.failColor,
            letterSpacing: 0,
          ),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 7,
          width: 7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.5),
            color: Colours.primaryColor,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Texts.normal(
          "Assign",
          color: Colours.primaryColor,
          letterSpacing: 0,
        ),
      ],
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
                  Texts.normal(
                    "BUFZA1234567",
                    color: Colours.titleColor,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                  ),
                  _renderStatus(),
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
