import 'package:courier_app/features/scan/widgets/scan_code_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scankit/flutter_scankit.dart';

class ScanCodeView extends StatefulWidget {
  final bool continuouslyScan;
  final ValueChanged<ScanResult>? scanOnResult;
  final Widget? actionWidget;
  const ScanCodeView({
    super.key,
    this.continuouslyScan = false,
    this.scanOnResult,
    this.actionWidget,
  });
  @override
  State<ScanCodeView> createState() => _ScanCodeViewState();
}

class _ScanCodeViewState extends State<ScanCodeView> {
  // 扫码控制器
  // _scanController.switchLight();
  // _scanController.pickPhoto();
  final ScanKitController _scanController = ScanKitController();

  @override
  void initState() {
    // 扫描结果回调
    _scanController.onResult.listen((result) {
      widget.scanOnResult?.call(result);
    });
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('ScanCodeView 销毁了');
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.height;

    const double scanBoxRadius = 10.0;
    // final double scanBoxWidth = 311.0;
    // final double scanBoxHeight = 311.0;
    final double scanBoxWidth = screenWidth - 64;
    final double scanBoxHeight = scanBoxWidth;
    final double scanBoxLeft = (screenWidth - scanBoxWidth) / 2.0;
    // final double scanBoxTop = (screenHeight - scanBoxHeight) / 2.0;
    double scanBoxTop = 100.0 + MediaQuery.of(context).padding.top;
    final scanBoxRect = Rect.fromLTWH(
      scanBoxLeft,
      scanBoxTop,
      scanBoxWidth,
      scanBoxHeight,
    );

    final actionWidgetTop = scanBoxTop + scanBoxHeight;

    return ClipRect(
      child: Stack(
        children: [
          // 扫码区域
          ScanKitWidget(
            controller: _scanController,
            continuouslyScan: widget.continuouslyScan,
            boundingBox: scanBoxRect,
          ),
          // 背景遮罩
          ScanCodeMask(
            scanBoxRect: scanBoxRect,
            scanBoxRadius: scanBoxRadius,
          ),
          Positioned(
            top: actionWidgetTop,
            left: 0,
            right: 0,
            child: widget.actionWidget != null
                ? widget.actionWidget!
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
