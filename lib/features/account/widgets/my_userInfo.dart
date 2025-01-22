import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../res/colours.dart';
import '../../../widgets/base/texts.dart';

class MyUserInfo extends ConsumerWidget {
  const MyUserInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        ClipOval(
          child: Image.network(
              width: 44,
              "https://rookie-files.oss-cn-shanghai.aliyuncs.com/girl.jpg"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: SizedBox(
            height: 44,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Texts.large(
                  "rookie",
                  fontWeight: FontWeight.w600,
                  color: Colours.titleColor,
                  letterSpacing: 0,
                ),
                Texts.small(
                  "Reno.guo@qq.con",
                  fontWeight: FontWeight.w600,
                  color: Colours.grey8F,
                  letterSpacing: 0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
