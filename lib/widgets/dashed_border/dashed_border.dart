import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../res/colours.dart';

class DashedBorder extends StatelessWidget {
  // 虚线宽度 默认 1
  final double width;

  // 虚线颜色 默认 灰色 E7E7E7
  final Color color;

  // 绘制虚线片段的 宽度 与 间距
  final List<double> dashPattern;

  const DashedBorder(
      {super.key,
      this.width = 1,
      this.color = Colours.greyE7,
      this.dashPattern = const <double>[3, 1]});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: color,
      dashPattern: dashPattern,
      strokeWidth: width,
      customPath: (size) {
        return Path()
          ..moveTo(0, 0)
          ..lineTo(size.width, 0);
      },
      // 默认长度为 容器限制范围内最大宽度
      // BoxConstraints maxWidth
      child: Container(
        height: 0,
      ),
    );
  }
}
