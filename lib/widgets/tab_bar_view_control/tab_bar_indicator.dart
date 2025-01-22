import 'package:courier_app/res/colours.dart';
import 'package:flutter/material.dart';

class TabBarIndicatorDecoration extends Decoration {
  final double indWidth;
  final double indHeight;
  final double radius;

  const TabBarIndicatorDecoration({
    this.indWidth = 34.0,
    this.indHeight = 2.0,
    this.radius = 0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomBoxPainter(
      this,
      indWidth,
      indHeight,
      radius,
      onChanged!,
    );
  }
}

class _CustomBoxPainter extends BoxPainter {
  final TabBarIndicatorDecoration decoration;
  final double indWidth;
  final double indHeight;
  final double radius;

  _CustomBoxPainter(
    this.decoration,
    this.indWidth,
    this.indHeight,
    this.radius,
    VoidCallback onChanged,
  ) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final size = configuration.size!;
    // 设置位置
    final newOffset = Offset(
      offset.dx + (size.width - indWidth) / 2,
      size.height - indHeight,
    );
    // 设置大小
    final Rect rect = newOffset &
        Size(
          indWidth,
          indHeight,
        );
    final Paint paint = Paint();
    // 设置颜色
    paint.color = Colours.primaryColor;
    // 设置样式
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect,
        Radius.circular(radius),
      ), // 圆角半径
      paint,
    );
  }
}
