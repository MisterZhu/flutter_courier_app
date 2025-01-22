import 'package:courier_app/features/scan/widgets/scan_code_view.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/text_styles.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:courier_app/utils/permission_utils.dart';
import 'package:courier_app/widgets/base/app_bars.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scankit/flutter_scankit.dart';

enum ScanCodePageType {
  normal, // 默认扫码
}

class ScanCodePage extends StatefulWidget {
  final String pageTitle;
  final bool canGoto;
  final bool continuouslyScan;
  final ValueChanged<ScanResult>? scanOnResult;
  final Widget? actionWidget;
  const ScanCodePage({
    super.key,
    this.pageTitle = 'Scan Bar Code',
    this.canGoto = true,
    this.continuouslyScan = false,
    this.scanOnResult,
    this.actionWidget,
  });

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  @override
  void initState() {
    // 校验权限
    PermissionUtils.checkCameraPermission();
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('ScanCodePage 销毁了');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //主要代码为extendBodyBehindAppBar 这个属性
      appBar: AppBars.transparent(
        title: widget.pageTitle,
        titleTextStyle: TextStyles.largeSemiBold.copyWith(color: Colors.white),
        foregroundColor: Colors.white,
      ),
      body: _renderPageContent(),
    );
  }

  Widget _renderPageContent() {
    return ScanCodeView(
      continuouslyScan: widget.continuouslyScan,
      scanOnResult: (result) {
        widget.scanOnResult?.call(result);
        if (widget.canGoto) {
          NavUtils.back();
        }
      },
      actionWidget: widget.actionWidget != null
          ? widget.actionWidget!
          : Padding(
              padding: const EdgeInsets.only(top: 64),
              child: Center(
                child: FilledButton(
                  style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(150, 44)),
                    backgroundColor: MaterialStatePropertyAll(Colours.grey50),
                  ),
                  onPressed: () {
                    NavUtils.back();
                  },
                  child: Texts.large('Cancel'),
                ),
              ),
            ),
    );
  }
}
