import 'package:courier_app/res.dart';
import 'package:courier_app/widgets/base/app_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GradientScaffold extends StatelessWidget {
  // --- AppBar ---
  final String? appBarTitle;
  final List<Widget>? actions;
  final NavBackCallback? onNavBack;
  final bool includeAppBar;
  final bool canBack;

  final Widget body;
  final Widget? bottomAppBar;
  final Widget? endDrawer;

  final Color? backgroundColor;
  final bool showBackground;
  final String? bgImageName;

  final bool removeStatusPadding;

  const GradientScaffold({
    super.key,
    required this.body,
    this.appBarTitle,
    this.actions,
    this.onNavBack,
    this.canBack = true,
    this.includeAppBar = true,
    this.bottomAppBar,
    this.endDrawer,
    this.removeStatusPadding = false,
    this.backgroundColor,
    this.showBackground = true,
    this.bgImageName,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('GradientScaffold build');
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: includeAppBar
          ? AppBars.transparent(
              title: appBarTitle,
              canBack: canBack,
              actions: actions,
              navBackCallback: onNavBack,
              systemUiOverlayStyle: SystemUiOverlayStyle.dark,
            )
          : null,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: bottomAppBar,
      backgroundColor: backgroundColor,
      endDrawer: endDrawer,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            showBackground
                ? Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Image.asset(
                      bgImageName ?? Res.base_bg,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : const SizedBox(),
            Positioned.fill(
              top: includeAppBar
                  ? mediaQuery.padding.top + AppBars.defaultHeight
                  : (removeStatusPadding ? 0 : mediaQuery.padding.top),
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}
