import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/text_styles.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:courier_app/widgets/text/highlight_text.dart';
import 'package:flutter/material.dart';

// typedef ValueCallback<T> = void Function(T value);

class TaskSearchResultItem extends StatelessWidget {
  final Map item;
  final String searchStr;
  final bool showDivider;
  final ValueChanged? onTap;

  const TaskSearchResultItem({
    super.key,
    required this.item,
    this.searchStr = '',
    this.showDivider = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          onTap?.call(item);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HighlightText(
                normalStyle: TextStyles.normalBold.copyWith(
                    color: Colours.primaryTextColor, letterSpacing: 0),
                highlightStyle: TextStyles.normalBold
                    .copyWith(color: Colours.primaryColor, letterSpacing: 0),
                content: item["name"],
                keyword: searchStr,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Texts.small(
                  'Jayce.Zhang +27 999999999',
                  color: Colours.grey8F,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Texts.small(
                  'Church St, Central, Cape Town, 8001 Church St, Central',
                  color: Colours.grey8F,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (showDivider) const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
