import 'package:flutter/material.dart';

import '../base/app_bars.dart';

class SafeTop extends StatelessWidget {
  final bool includeAppBar;

  const SafeTop({
    super.key,
    this.includeAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).padding.top + (includeAppBar ? AppBars.defaultHeight : 0));
  }
}
