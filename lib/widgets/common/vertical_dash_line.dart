import 'package:courier_app/res/colours.dart';
import 'package:flutter/material.dart';

class VerticalDashLine extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  VerticalDashLine({
    super.repaint,
    this.color = Colours.divider,
    this.dashWidth = 2.5,
    this.dashSpace = 2.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = size.width;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);

      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(VerticalDashLine oldDelegate) {
    return color != oldDelegate.color ||
        dashWidth != oldDelegate.dashWidth ||
        dashSpace != oldDelegate.dashSpace;
  }
}
