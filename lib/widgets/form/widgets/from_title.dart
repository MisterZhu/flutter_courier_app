import 'package:flutter/cupertino.dart';

import '../../../res/colours.dart';
import '../../../res/text_styles.dart';

class FormTitle extends StatelessWidget {
  // 是否必填
  final bool required;
  // 标题
  final String? formTitle;

  const FormTitle({
    super.key,
    this.required = false,
    this.formTitle,
  });

  @override
  Widget build(BuildContext context) {
    return formTitle?.isNotEmpty != true
        ? Container()
        : Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8),
            child: RichText(
              textAlign: TextAlign.start, // 设置富文本对齐
              text: TextSpan(
                style: TextStyles.normal.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colours.primaryTextColor),
                children: [
                  TextSpan(text: formTitle),
                  required
                      ? const TextSpan(
                          text: "*",
                          style: TextStyle(color: Colours.requiredColor))
                      : const TextSpan(text: '')
                ],
              ), // 方式
            ),
          );
  }
}
