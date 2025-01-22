import 'package:flutter/cupertino.dart';

extension GlobalKeyExtension on GlobalKey {
  // 获取组件在平不得绝对位置
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();

    final matrix = renderObject?.getTransformTo(null);

    if (matrix != null && renderObject?.paintBounds != null) {
      final rect = MatrixUtils.transformRect(matrix, renderObject!.paintBounds);

      return rect;
    } else {
      return null;
    }
  }
}
