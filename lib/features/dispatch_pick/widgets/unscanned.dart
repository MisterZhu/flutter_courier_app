import 'package:flutter/material.dart';

import '../../../res/colours.dart';
import '../../../widgets/base/texts.dart';

// Unscanned Order
class Unscanned extends StatelessWidget {
  final String orderNo;

  final VoidCallback onTap;

  const Unscanned({super.key, required this.orderNo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colours.quotationAlertTextColor,
            width: 0.5,
          )),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Texts.normal(
              "Order No：$orderNo",
              fontWeight: FontWeight.w600,
              color: Colours.titleColor,
              letterSpacing: 0,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Material(
              color: Colours.quotationAlertTextColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(7),
                bottomLeft: Radius.circular(8),
              ),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  onTap();
                },
                child: SizedBox(
                  width: 50.5,
                  height: 19,
                  child: Center(
                    child: Texts.smallest(
                      "To Scan",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
