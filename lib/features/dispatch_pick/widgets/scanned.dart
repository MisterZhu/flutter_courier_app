import 'package:flutter/material.dart';
import '../../../res/colours.dart';
import '../../../widgets/base/texts.dart';

// Scanned Order
class Scanned extends StatelessWidget {
  final String orderNo;

  final VoidCallback onTap;

  const Scanned({super.key, required this.orderNo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xffE9F5F0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xff2BA471),
          width: 0.5,
        ),
      ),
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
              color: const Color(0xff2BA471),
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
                  width: 60,
                  height: 19,
                  child: Center(
                    child: Texts.smallest(
                      "Scanned",
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
