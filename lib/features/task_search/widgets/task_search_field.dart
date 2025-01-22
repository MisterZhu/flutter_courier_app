import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/dimens.dart';
import 'package:courier_app/res/text_styles.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';

class TaskSearchField extends StatefulWidget {
  final ValueChanged? searchOnChanged;
  const TaskSearchField({
    super.key,
    this.searchOnChanged,
  });

  @override
  State<TaskSearchField> createState() => _TaskSearchFieldState();
}

class _TaskSearchFieldState extends State<TaskSearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: Dimens.borderRadius22,
        ),
        height: 44,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 12),
              child: Image.asset(Res.search_icon_main),
            ),
            Expanded(
              child: TextField(
                style: TextStyles.normalBold,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    top: 5,
                    bottom: 7,
                  ),
                  isDense: true,
                ),
                onChanged: (String value) {
                  // 变更逻辑
                  widget.searchOnChanged?.call(value);
                },
                // onSubmitted: (String value) {
                //   // 搜索逻辑
                //   FocusManager.instance.primaryFocus?.unfocus();
                // }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Container(
                width: 1.0,
                height: 16.0,
                color: Colours.divider,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () {
                  NavUtils.back();
                },
                child: Texts.normal(
                  'Cancel',
                  color: Colours.grey8F,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
