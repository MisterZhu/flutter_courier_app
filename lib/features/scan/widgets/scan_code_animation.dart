import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:flutter/material.dart';

class ScanCodeAnimation extends StatefulWidget {
  final double scanAnimationWidth; // 宽度
  final double scanAnimationHeight; // 高度
  final double scanAnimationRadius; // 圆角

  const ScanCodeAnimation({
    super.key,
    required this.scanAnimationWidth,
    required this.scanAnimationHeight,
    required this.scanAnimationRadius,
  });

  @override
  State<ScanCodeAnimation> createState() => _ScanCodeAnimationState();
}

class _ScanCodeAnimationState extends State<ScanCodeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0.0, -1.0), // 从上往下移动
      end: const Offset(0.0, 1.0), // 移动到下边界
    ).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset(); // 重置动画
        _controller.forward(); // 重新执行动画
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    debugPrint('ScanCodeAnimation 销毁了');
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.scanAnimationRadius;

    final viewWidth = widget.scanAnimationWidth;
    final viewHeight = widget.scanAnimationHeight;
    final animationWidth = viewWidth - 4;
    final animationHeight = viewHeight - 4;

    return Container(
      color: Colors.transparent,
      width: viewWidth,
      height: viewHeight,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: animationWidth,
              height: animationHeight,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
              ),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  return Stack(
                    children: [
                      Positioned(
                        top: _animation.value.dy *
                            animationHeight, // 根据动画值设置top位置
                        left: 0,
                        right: 0,
                        child: Container(
                          width: animationWidth,
                          height: animationHeight,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colours.scanAnimationColor,
                              ], // 渐变色
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Center(
            child: Image.asset(
              Res.scan_box,
              width: viewWidth,
              height: viewHeight,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
