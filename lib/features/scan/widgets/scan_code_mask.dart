import 'package:courier_app/features/scan/widgets/scan_code_animation.dart';
import 'package:courier_app/res/colours.dart';
import 'package:flutter/material.dart';

const Color defaultBackgroundColor = Colours.scanMaskColor;

class ScanCodeMask extends StatefulWidget {
  final Rect scanBoxRect; // 区域
  final double scanBoxRadius; // 圆角
  final Color backgroundColor; // 背景颜色

  const ScanCodeMask({
    super.key,
    required this.scanBoxRect,
    this.scanBoxRadius = 0,
    this.backgroundColor = defaultBackgroundColor,
  });

  @override
  State<ScanCodeMask> createState() => _ScanCodeMaskState();
}

class _ScanCodeMaskState extends State<ScanCodeMask> {
  @override
  void dispose() {
    debugPrint('ScanCodeMask 销毁了');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rect = widget.scanBoxRect;
    final radius = widget.scanBoxRadius;
    final backgroundColor = widget.backgroundColor;

    final top = rect.top;
    final left = rect.left;
    final width = rect.width;
    final height = rect.height;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: ClipPath(
            clipper: _TopMaskRectClipper(
              clipRect: rect,
              borderRadius: radius,
            ),
            child: Container(
              color: backgroundColor,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: ClipPath(
            clipper: _BottomMaskRectClipper(
              clipRect: rect,
              borderRadius: radius,
            ),
            child: Container(
              color: backgroundColor,
            ),
          ),
        ),
        // 扫描动画
        Positioned(
          top: top - 2,
          left: left - 2,
          child: ScanCodeAnimation(
            scanAnimationWidth: width + 4,
            scanAnimationHeight: height + 4,
            scanAnimationRadius: radius,
          ),
        ),
      ],
    );

    // return Stack(
    //   children: [
    //     Positioned(
    //       top: 0,
    //       bottom: 0,
    //       left: 0,
    //       right: 0,
    //       child: ClipPath(
    //         clipper: _TopMaskCenterClipper(
    //           clipWidth: width,
    //           clipHeight: height,
    //           borderRadius: radius,
    //         ),
    //         child: Container(
    //           color: backgroundColor,
    //         ),
    //       ),
    //     ),
    //     Positioned(
    //       top: 0,
    //       bottom: 0,
    //       left: 0,
    //       right: 0,
    //       child: ClipPath(
    //         clipper: _TopMaskCenterClipper(
    //           clipWidth: width,
    //           clipHeight: height,
    //           borderRadius: radius,
    //         ),
    //         child: Container(
    //           color: backgroundColor,
    //         ),
    //       ),
    //     ),
    //     // 扫描动画
    //     Positioned(
    //       top: top - 2,
    //       left: left - 2,
    //       child: ScanCodeAnimation(
    //         scanAnimationWidth: width + 4,
    //         scanAnimationHeight: height + 4,
    //         scanAnimationRadius: radius,
    //       ),
    //     )
    //   ],
    // );
  }
}

class _TopMaskRectClipper extends CustomClipper<Path> {
  final double _clipTop;
  final double _clipLeft;
  final double _clipWidth;
  final double _borderRadius;
  _TopMaskRectClipper({
    required Rect clipRect,
    required double borderRadius,
  })  : _clipTop = clipRect.top,
        _clipLeft = clipRect.left,
        _clipWidth = clipRect.width,
        _borderRadius = borderRadius;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(
      0,
      0,
    );
    path.lineTo(
      0,
      _clipTop + _borderRadius + 0.1,
    );
    path.lineTo(
      _clipLeft,
      _clipTop + _borderRadius + 0.1,
    );
    // 左上角
    path.arcToPoint(
      Offset(
        _clipLeft + _borderRadius,
        _clipTop,
      ),
      radius: Radius.circular(_borderRadius),
    );
    path.lineTo(
      _clipLeft + _clipWidth - _borderRadius,
      _clipTop,
    );
    // 右上角
    path.arcToPoint(
      Offset(
        _clipLeft + _clipWidth,
        _clipTop + _borderRadius + 0.1,
      ),
      radius: Radius.circular(_borderRadius),
    );
    path.lineTo(
      size.width,
      _clipTop + _borderRadius + 0.1,
    );
    path.lineTo(
      size.width,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _BottomMaskRectClipper extends CustomClipper<Path> {
  final double _clipTop;
  final double _clipLeft;
  final double _clipWidth;
  final double _clipHeight;
  final double _borderRadius;
  _BottomMaskRectClipper({
    required Rect clipRect,
    required double borderRadius,
  })  : _clipTop = clipRect.top,
        _clipLeft = clipRect.left,
        _clipWidth = clipRect.width,
        _clipHeight = clipRect.height,
        _borderRadius = borderRadius;

  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(
      0,
      _clipTop + _borderRadius,
    );
    path.lineTo(
      _clipLeft,
      _clipTop + _borderRadius,
    );
    path.lineTo(
      _clipLeft,
      _clipTop + _clipHeight - _borderRadius,
    );
    // 左下角
    path.arcToPoint(
      Offset(
        _clipLeft + _borderRadius,
        _clipTop + _clipHeight,
      ),
      radius: Radius.circular(_borderRadius),
      clockwise: false,
    );
    path.lineTo(
      _clipLeft + _clipWidth - _borderRadius,
      _clipTop + _clipHeight,
    );
    // 右下角
    path.arcToPoint(
      Offset(
        _clipLeft + _clipWidth,
        _clipTop + _clipHeight - _borderRadius,
      ),
      radius: Radius.circular(_borderRadius),
      clockwise: false,
    );
    path.lineTo(
      _clipLeft + _clipWidth,
      _clipTop + _borderRadius,
    );
    path.lineTo(
      size.width,
      _clipTop + _borderRadius,
    );
    path.lineTo(
      size.width,
      size.height,
    );
    path.lineTo(
      0,
      size.height,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

// class _TopMaskCenterClipper extends CustomClipper<Path> {
//   final double _clipWidth;
//   final double _clipHeight;
//   final double _borderRadius;
//   _TopMaskCenterClipper({
//     required double clipWidth,
//     required double clipHeight,
//     required double borderRadius,
//   })  : _clipWidth = clipWidth,
//         _clipHeight = clipHeight,
//         _borderRadius = borderRadius;
//
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.moveTo(
//       0,
//       0,
//     );
//     path.lineTo(
//       0,
//       size.height / 2 + 0.1,
//     );
//     path.lineTo(
//       (size.width - _clipWidth) / 2,
//       size.height / 2 + 0.1,
//     );
//     path.lineTo(
//       (size.width - _clipWidth) / 2,
//       (size.height - _clipHeight) / 2 + _borderRadius,
//     );
//     // 左上角
//     path.arcToPoint(
//       Offset(
//         (size.width - _clipWidth) / 2 + _borderRadius,
//         (size.height - _clipHeight) / 2,
//       ),
//       radius: Radius.circular(_borderRadius),
//     );
//     path.lineTo(
//       (size.width + _clipWidth) / 2 - _borderRadius,
//       (size.height - _clipHeight) / 2,
//     );
//     // 右上角
//     path.arcToPoint(
//       Offset(
//         (size.width + _clipWidth) / 2,
//         (size.height - _clipHeight) / 2 + _borderRadius,
//       ),
//       radius: Radius.circular(_borderRadius),
//     );
//     path.lineTo(
//       (size.width + _clipWidth) / 2,
//       size.height / 2,
//     );
//     path.lineTo(
//       size.width,
//       size.height / 2,
//     );
//     path.lineTo(
//       size.width,
//       0,
//     );
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
//
// class _BottomMaskCenterClipper extends CustomClipper<Path> {
//   final double _clipWidth;
//   final double _clipHeight;
//   final double _borderRadius;
//   _BottomMaskCenterClipper({
//     required double clipWidth,
//     required double clipHeight,
//     required double borderRadius,
//   })  : _clipWidth = clipWidth,
//         _clipHeight = clipHeight,
//         _borderRadius = borderRadius;
//
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//
//     path.moveTo(
//       0,
//       size.height / 2,
//     );
//     path.lineTo(
//       (size.width - _clipWidth) / 2,
//       size.height / 2,
//     );
//     path.lineTo(
//       (size.width - _clipWidth) / 2,
//       (size.height + _clipHeight) / 2 - _borderRadius,
//     );
//     // 左下角
//     path.arcToPoint(
//       Offset(
//         (size.width - _clipWidth) / 2 + _borderRadius,
//         (size.height + _clipHeight) / 2,
//       ),
//       radius: Radius.circular(_borderRadius),
//       clockwise: false,
//     );
//     path.lineTo(
//       (size.width + _clipWidth) / 2 - _borderRadius,
//       (size.height + _clipHeight) / 2,
//     );
//     // 右下角
//     path.arcToPoint(
//       Offset(
//         (size.width + _clipWidth) / 2,
//         (size.height + _clipHeight) / 2 - _borderRadius,
//       ),
//       radius: Radius.circular(_borderRadius),
//       clockwise: false,
//     );
//     path.lineTo(
//       (size.width + _clipWidth) / 2,
//       size.height / 2,
//     );
//     path.lineTo(
//       size.width,
//       size.height / 2,
//     );
//     path.lineTo(
//       size.width,
//       size.height,
//     );
//     path.lineTo(
//       0,
//       size.height,
//     );
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
//
// class _ScanMaskRectClipper extends CustomClipper<Path> {
//   final Rect contentRect;
//   final double borderRadius;
//
//   _ScanMaskRectClipper({
//     required this.contentRect,
//     required this.borderRadius,
//   });
//
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//
//     path.addRRect(
//       RRect.fromRectAndCorners(
//         contentRect,
//         topLeft: Radius.circular(borderRadius),
//         topRight: Radius.circular(borderRadius),
//         bottomLeft: Radius.circular(borderRadius),
//         bottomRight: Radius.circular(borderRadius),
//       ),
//     );
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
