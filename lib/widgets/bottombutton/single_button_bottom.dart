import 'package:flutter/material.dart';

import '../../res/colours.dart';
import '../../res/dimens.dart';
import '../base/texts.dart';

class SingleButtonBottom extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  final EdgeInsetsGeometry padding;
  const SingleButtonBottom(
      {super.key,
      required this.title,
      this.onTap,
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 8)});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: padding,
      child: Expanded(
          child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
              color: Colours.taskBussiness1,
              borderRadius: Dimens.borderRadius25),
          alignment: Alignment.center,
          child: Texts.large(title, color: Colors.white),
        ),
      )),
    );
  }
}
