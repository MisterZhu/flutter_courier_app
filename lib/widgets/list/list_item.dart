import 'package:courier_app/res/text_styles.dart';
import 'package:flutter/material.dart';

import '../../res.dart';

class ListItem extends StatelessWidget {
  // 图标名称
  final String listImageName;
  // 标题
  final String listTitle;
  // 字体样式
  final TextStyle? listTitleStyle;
  // 点击事件
  final VoidCallback listOnTap;
  // 底部间距
  final double? bottomGap;

  const ListItem(
    this.listImageName,
    this.listTitle, {
    super.key,
    this.listTitleStyle,
    required this.listOnTap,
    this.bottomGap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 49,
          child: _renderListItem(listImageName, listTitle),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: bottomGap ?? 0),
        )
      ],
    );
  }

  Widget _renderListItem(String listImage, String listTitle) {
    return Material(
      color: Colors.white,
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Ink(
          child: InkWell(
        onTap: () {
          listOnTap();
        },
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset(
                listImageName,
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  listTitle,
                  style: listTitleStyle ??
                      TextStyles.large.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Image.asset(
                Res.list_arrow,
                width: 5,
                height: 9,
              ),
            )
          ],
        ),
      )),
    );
  }
}
