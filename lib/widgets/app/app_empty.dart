import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';

enum AppEmptyStyle {
  center,
  appBarAndTabBar,
}

class AppEmpty extends StatelessWidget {
  final String icon;
  final String text;
  final double? gap;

  final AppEmptyStyle style;

  const AppEmpty({
    super.key,
    required this.icon,
    required this.text,
    this.gap,
    this.style = AppEmptyStyle.center,
  });

  @override
  Widget build(BuildContext context) {
    const iconSize = 144.0;

    final widgets = [
      Image.asset(icon, width: iconSize, height: iconSize),
      if (gap != null) SizedBox(height: gap),
      Texts.large(text),
    ];

    switch (style) {
      case AppEmptyStyle.center:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        );
      case AppEmptyStyle.appBarAndTabBar:
        {
          final screenHeight = MediaQuery.of(context).size.height;

          final bottomPadding = (screenHeight - iconSize - (gap ?? 0) - 20) / 2;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...widgets,
              SizedBox(height: bottomPadding),
              const SizedBox(height: 60),
            ],
          );
        }
    }
  }
}
