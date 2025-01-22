import 'package:courier_app/features/pick_up_deatil/pick_up_child_detail.dart';
import 'package:courier_app/utils/dialog_utils.dart';
import 'package:courier_app/widgets/bottombutton/single_button_bottom.dart';
import 'package:courier_app/widgets/scaffold/gradient_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../res.dart';
import '../../res/colours.dart';
import '../../res/dimens.dart';
import '../../utils/common_utils.dart';
import '../../utils/nav_utils.dart';
import '../../widgets/base/cards.dart';
import '../../widgets/base/texts.dart';

class PickUpDetailPage extends StatefulWidget {
  const PickUpDetailPage({super.key});

  @override
  State<PickUpDetailPage> createState() => _PickUpDetailPageState();
}

class _PickUpDetailPageState extends State<PickUpDetailPage> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        appBarTitle: 'Pick Up Detail',
        body: Column(
          children: [
            Cards.radius12(
                padding: const EdgeInsets.all(15),
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Texts.normal('Sender：', color: Colours.grey63),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Texts.normalSemiBold('Frankey',
                            color: Colours.titleColor),
                        Texts.normalSemiBold('+27 999999999',
                            color: Colours.titleColor),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Texts.normal(
                                '135 Cowen Nthuli 135 Lyric Townhouses 7, Sandton, 2196',
                                color: Colours.titleColor)),
                        const SizedBox(width: 12),
                        Image.asset(Res.local, width: 20, height: 20)
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                                borderRadius: Dimens.borderRadius22,
                                color: Colours.taskBussiness2,
                                border: Border.all(
                                    color: Colours.taskBussiness1, width: 0.5)),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(Res.phone_call,
                                    width: 20, height: 20),
                                const SizedBox(width: 10),
                                Texts.normalSemiBold('Phone Call',
                                    color: Colours.taskBussiness1)
                              ],
                            ),
                          ),
                        )),
                        const SizedBox(width: 12),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                                borderRadius: Dimens.borderRadius22,
                                color: Colours.whatsAppColor2,
                                border: Border.all(
                                    color: Colours.whatsAppColor1, width: 0.5)),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(Res.whats_app,
                                    width: 20, height: 20),
                                const SizedBox(width: 10),
                                Texts.normalSemiBold('WhatsApp',
                                    color: Colours.whatsAppColor1)
                              ],
                            ),
                          ),
                        ))
                      ],
                    )
                  ],
                )),
            Cards.radius12(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 12, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Texts.largeSemiBold('Token Number',
                        color: Colours.titleColor),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: const BoxDecoration(
                              color: Colours.greyF5,
                              borderRadius: Dimens.leftBorderRadius8),
                          child: const TextField(
                            maxLines: 1,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15),
                                hintText: 'Last Five Order No',
                                hintMaxLines: 1,
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Colours.grey8F)),
                          ),
                        )),
                        GestureDetector(
                          onTap: () {
                            _showPickUpDialog();
                          },
                          child: Container(
                            height: 44,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: const BoxDecoration(
                                color: Colours.taskBussiness1,
                                borderRadius: Dimens.rightBorderRadius8),
                            child: Texts.normal('Pick', color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Image.asset(Res.scan_code, width: 24, height: 24)
                      ],
                    )
                  ],
                )),
            Flexible(
              child: Cards.radius12(
                  margin:
                      const EdgeInsets.only(bottom: 12, left: 15, right: 15),
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Texts.largeSemiBold('Order List',
                              color: Colours.titleColor),
                          Texts.largeSemiBold('28/112',
                              color: Colours.titleColor),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: Scrollbar(
                          child: ListView.builder(
                              padding: const EdgeInsets.only(),
                              itemCount: 10,
                              itemBuilder: (c, i) {
                                return orderWidget(i);
                              }),
                        ),
                      )
                    ],
                  )),
            ),
            SingleButtonBottom(
                title: 'Confirm',
                onTap: CommonUtils.debounce2(() {
                  NavUtils.to(const PickUpChildDetailPage());
                }))
          ],
        ));
  }

  Widget orderWidget(int pos) {
    bool scanned = (pos % 2) == 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            decoration: BoxDecoration(
                color: scanned ? Colours.orderScanned : Colours.greyF5,
                borderRadius: Dimens.borderRadius8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Texts.normalSemiBold('BUFZA60221*****YQ',
                          color: Colours.titleColor),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Texts.small('Pickup String',
                                  color: Colours.grey8F),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Texts.normalSemiBold(
                                      scanned ? 'PS9999999999' : 'More',
                                      color: Colours.titleColor),
                                  const SizedBox(width: 2),
                                  Image.asset(Res.arrow_right,
                                      width: 18, height: 18)
                                ],
                              )
                            ],
                          )),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Texts.small('Scanned/Total',
                                  color: Colours.grey8F),
                              const SizedBox(height: 8),
                              Texts.normalSemiBold('1/1',
                                  color: Colours.titleColor)
                            ],
                          ))
                        ],
                      )
                    ],
                  ),
                ),
                Visibility(
                    visible: !scanned,
                    child: Container(
                      height: 30,
                      width: 1,
                      color: Colours.greyE7,
                    )),
                const SizedBox(width: 15),
                Visibility(
                    visible: !scanned,
                    child: Image.asset(Res.scan_code_ps, width: 24, height: 24))
              ],
            ),
          ),
          scanned ? _itemLineBorder(Colours.okColor) : const SizedBox(),
          _positionedTipWidget()
        ],
      ),
    );
  }

  Positioned _itemLineBorder(Color okColor) {
    return Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: IgnorePointer(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: Dimens.borderRadius8,
                border: Border.all(color: okColor, width: 0.5)),
          ),
        ));
  }

  Positioned _positionedTipWidget() {
    return Positioned(
        top: 0,
        right: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
          decoration: const BoxDecoration(
              color: Colours.okColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8))),
          child: Texts.small('Scanned', color: Colors.white),
        ));
  }

  void _showPickUpDialog() {
    DialogUtils.showPrimaryGradientDialog(
        title: 'BUFZA6022131029YQ',
        contentWidget: Container(
          constraints: const BoxConstraints(maxHeight: 200),
          child: ListView.builder(itemBuilder: (c, i) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 7.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Texts.normal('Pickup String${i + 1}', color: Colours.grey63),
                  const SizedBox(height: 10),
                  Texts.normalSemiBold('PS9999999999',
                      color: Colours.titleColor),
                ],
              ),
            );
          }),
        ),
        positiveText: 'Sure');
  }
}
