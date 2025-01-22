import 'dart:ui';

import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/dimens.dart';
import 'package:courier_app/widgets/base/cards.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:courier_app/widgets/resizable_box/resizable_box.dart';
import 'package:flutter/material.dart';

class AreaSort extends StatefulWidget {
  const AreaSort({super.key});

  @override
  State<AreaSort> createState() => _AreaSortState();
}

class _AreaSortState extends State<AreaSort> {
  @override
  Widget build(BuildContext context) {
    return ResizableBox(
      headerWidget: _renderActionView(),
      contentWidget: _renderSortView(),
    );
  }

  Widget _renderActionView() {
    double actionIconWidth = 18.0;
    Color actionTitleColor = Colours.primaryColor;

    const cardPadding = EdgeInsets.all(15);

    const tagPadding = EdgeInsets.symmetric(
      horizontal: 4,
      vertical: 1,
    );
    const startTagColor = Colours.primaryColor;
    BoxDecoration startTagDecoration = const BoxDecoration(
        color: startTagColor,
        borderRadius: BorderRadius.only(
          topLeft: Dimens.radius6,
          topRight: Dimens.radius6,
          bottomRight: Dimens.radius6,
        ));
    const terminalTagColor = Colours.failColor;
    BoxDecoration terminalTagDecoration = const BoxDecoration(
        color: terminalTagColor,
        borderRadius: BorderRadius.only(
          topLeft: Dimens.radius6,
          topRight: Dimens.radius6,
          bottomRight: Dimens.radius6,
        ));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Image.asset(Res.primary_close, width: actionIconWidth),
                      const SizedBox(width: 8),
                      Texts.normalBold('Cancel', color: actionTitleColor),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Image.asset(Res.primary_check, width: actionIconWidth),
                      const SizedBox(width: 8),
                      Texts.normalBold('Confirm', color: actionTitleColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Cards.normal(
                  padding: cardPadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 18,
                        padding: tagPadding,
                        decoration: startTagDecoration,
                        child: Texts.small(
                          'Start',
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Texts.normalBold(
                              'HA HA HA HA HA HA HA HA HA HA',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Image.asset(Res.list_arrow_black),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Cards.normal(
                  padding: cardPadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 18,
                        padding: tagPadding,
                        decoration: terminalTagDecoration,
                        child: Texts.small(
                          'Terminal',
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Texts.normalBold(
                              'HA HA HA HA HA HA HA HA HA HA',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Image.asset(Res.list_arrow_black),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _renderSortView() {
    final List<String> items =
        List<String>.generate(50, (int index) => '$index');

    final List<Card> cards = [
      for (int index = 0; index < items.length; index += 1)
        _renderAreaItem(items[index])
    ];

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double scale = lerpDouble(1, 1.0, animValue)!;
          return Transform.scale(
            scale: scale,
            // Create a Card based on the color and the content of the dragged one
            // and set its elevation to the animated value.
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: cards[index].child,
            ),
          );
        },
        child: child,
      );
    }

    return Column(
      children: [
        Expanded(
          child: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            proxyDecorator: proxyDecorator,
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            children: cards,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final String item = items.removeAt(oldIndex);
                items.insert(newIndex, item);
              });

              // 
            },
          ),
        )
      ],
    );
  }

  Card _renderAreaItem(item) {
    return Card(
      key: ValueKey(item),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Texts.normalBold(item),
                  ),
                  Texts.normalBold('Graph $item')
                ],
              ),
            ),
            Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Texts.normal('Delete', color: Colours.failColor),
                  ),
                ),
                const SizedBox(width: 15),
                Image.asset(Res.drag_handle),
              ],
            )
          ],
        ),
      ),
    );
  }
}
