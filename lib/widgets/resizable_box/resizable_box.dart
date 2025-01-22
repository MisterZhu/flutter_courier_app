import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/dimens.dart';
import 'package:flutter/material.dart';

const double ResizableBoxHeightRatio0_3 = 0.3;
const double ResizableBoxHeightRatio0_5 = 0.5;
const double ResizableBoxHeightRatio0_8 = 0.8;

class ResizableBox extends StatefulWidget {
  final double defaultHeightRatio;
  final Widget? indicatorWidget;
  final Widget? headerWidget;
  final Widget? contentWidget;
  final Widget? bottomWidget;

  const ResizableBox({
    super.key,
    this.defaultHeightRatio = ResizableBoxHeightRatio0_3,
    this.indicatorWidget,
    this.headerWidget,
    this.contentWidget,
    this.bottomWidget,
  });

  @override
  State<ResizableBox> createState() => _ResizableBoxState();
}

class _ResizableBoxState extends State<ResizableBox> {
  // 父组件宽度
  late double _parentWidgetWidth;
  // 父组件高度
  late double _parentWidgetHeight;

  // 高度比例
  late double _heightRatio;

  static const Radius containerRadius = Dimens.radius15;

  // 动画
  static const Duration animatedDuration = Duration(milliseconds: 100);

  // 指示器
  static const EdgeInsets indicatorMargin = EdgeInsets.all(10);
  static const double indicatorWidth = 54;
  static const double indicatorHeight = 4;
  static const Color indicatorColor = Colors.white;
  static const BorderRadius indicatorRadius =
      BorderRadius.all(Radius.circular(2));

  @override
  void initState() {
    _heightRatio = widget.defaultHeightRatio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // _parentWidgetWidth = constraints.maxWidth;
        // _parentWidgetHeight = constraints.maxHeight;
        _parentWidgetWidth = MediaQuery.of(context).size.width;
        _parentWidgetHeight = MediaQuery.of(context).size.height;

        return AnimatedContainer(
          duration: animatedDuration,
          curve: Curves.linear, // 使用回弹曲线
          width: _parentWidgetWidth,
          height: _parentWidgetHeight * _heightRatio,
          child: Container(
            decoration: const BoxDecoration(
              color: Colours.greyF5,
              borderRadius: BorderRadius.only(
                topLeft: containerRadius,
                topRight: containerRadius,
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onVerticalDragUpdate: _onVerticalDragUpdate,
                  onVerticalDragEnd: _onVerticalDragEnd,
                  child: widget.indicatorWidget != null
                      ? widget.indicatorWidget!
                      : Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Container(
                            margin: indicatorMargin,
                            width: indicatorWidth,
                            height: indicatorHeight,
                            decoration: const BoxDecoration(
                              color: indicatorColor,
                              borderRadius: indicatorRadius,
                            ),
                          ),
                        ),
                ),
                widget.headerWidget != null
                    ? widget.headerWidget!
                    : const SizedBox(),
                Expanded(
                  child: widget.contentWidget != null
                      ? widget.contentWidget!
                      : const SizedBox(),
                ),
                widget.bottomWidget != null
                    ? widget.bottomWidget!
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }

  // 拖拽方法
  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      // 设置高度比例
      _heightRatio -= details.primaryDelta! / _parentWidgetHeight;
      // 限制高度比例在0.3到0.8之间
      _heightRatio = _heightRatio.clamp(
          ResizableBoxHeightRatio0_3, ResizableBoxHeightRatio0_8);
    });
  }

  // 拖拽结束方法
  void _onVerticalDragEnd(DragEndDetails details) {
    // 找到里的最近的高度比例
    double targetHeightRatio = _findNearest(_heightRatio);
    setState(() {
      // 设置新的高度比例
      _heightRatio = targetHeightRatio;
    });
  }

  // 查询最近的高度比例
  double _findNearest(double value) {
    List<double> array = [
      ResizableBoxHeightRatio0_3,
      ResizableBoxHeightRatio0_5,
      ResizableBoxHeightRatio0_8
    ];
    double nearest = array.first;
    double minDifference = (value - nearest).abs();

    for (double element in array) {
      double difference = (value - element).abs();
      if (difference < minDifference) {
        minDifference = difference;
        nearest = element;
      }
    }

    return nearest;
  }
}
