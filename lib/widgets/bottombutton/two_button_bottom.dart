import 'package:flutter/material.dart';

import '../../res/colours.dart';
import '../../res/dimens.dart';
import '../base/texts.dart';

class TwoButtonBottom extends StatelessWidget {
  final Widget leftWidget;
  final Widget rightWidget;
  final double height;
  final Color leftBackgroundColor;
  final Color rightBackgroundColor;
  final bool isBorder;
  final Color borderColor;
  final BorderRadiusGeometry borderRadius;

  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;

  final EdgeInsetsGeometry padding;
  const TwoButtonBottom({
    super.key,
    required this.leftWidget,
    required this.rightWidget,
    this.onLeftTap,
    this.onRightTap,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    this.height = 44,
    this.leftBackgroundColor = Colours.taskBussiness1,
    this.rightBackgroundColor = Colours.taskBussiness2,
    this.isBorder = true,
    this.borderColor = Colours.taskBussiness1,
    this.borderRadius = Dimens.borderRadius25,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: padding,
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: onLeftTap,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                  color: leftBackgroundColor, borderRadius: borderRadius),
              alignment: Alignment.center,
              child: leftWidget,
            ),
          )),
          const SizedBox(width: 12),
          Expanded(
              child: GestureDetector(
            onTap: onRightTap,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                  border: isBorder ? Border.all(color: borderColor) : null,
                  color: rightBackgroundColor,
                  borderRadius: borderRadius),
              alignment: Alignment.center,
              child: rightWidget,
            ),
          ))
        ],
      ),
    );
  }
}
