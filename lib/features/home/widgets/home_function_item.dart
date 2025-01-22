import 'package:flutter/material.dart';

import '../../../widgets/base/texts.dart';

class HomeFunctionItem extends StatelessWidget {
  final String title;

  final String imgPath;

  final VoidCallback onClick;

  const HomeFunctionItem(
      {super.key,
      required this.imgPath,
      required this.title,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClick,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imgPath,
              width: 54,
            ),
            Texts.norma(
              title,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
          ],
        ),
      ),
    );
  }
}
