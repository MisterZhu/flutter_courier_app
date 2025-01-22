import 'package:courier_app/utils/dialog_utils.dart';
import 'package:courier_app/widgets/add_picture/add_picture_widget.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:courier_app/widgets/bottombutton/two_button_bottom.dart';
import 'package:courier_app/widgets/scaffold/gradient_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../../res.dart';
import '../../res/colours.dart';
import '../../res/dimens.dart';
import '../../utils/common_utils.dart';
import '../../widgets/base/cards.dart';
import '../../widgets/bottombutton/single_button_bottom.dart';
import '../dispatch_detail/widgets/reason_select.dart';

class PickUpChildDetailPage extends StatefulWidget {
  const PickUpChildDetailPage({super.key});

  @override
  State<PickUpChildDetailPage> createState() => _PickUpChildDetailPageState();
}

class _PickUpChildDetailPageState extends State<PickUpChildDetailPage> {
  final SignatureController _controller =
      SignatureController(penStrokeWidth: 1, penColor: Colors.black);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        appBarTitle: 'Pick Up Detail',
        body: Column(
          children: [
            Container(
                constraints: const BoxConstraints(maxHeight: 325),
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: Dimens.borderRadius12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Texts.largeSemiBold('28/112', color: Colours.titleColor)
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Scrollbar(
                          child: ListView.builder(
                              padding: const EdgeInsets.only(),
                              itemCount: 10,
                              itemBuilder: (c, i) {
                                return _orderItem(i);
                              })),
                    )
                  ],
                )),
            Cards.radius12(
                margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Texts.largeSemiBold('Shipper Signature',
                            color: Colours.titleColor),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colours.greyF5,
                              borderRadius: Dimens.borderRadius6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _shipperTabWidget('HandWriting'),
                              _shipperTabWidget('Photo'),
                            ],
                          ),
                        )
                      ],
                    ),
                    _shipperTab == 'HandWriting'
                        ? Stack(
                            children: [
                              Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 150),
                                decoration: const BoxDecoration(
                                    color: Colours.greyF5,
                                    borderRadius: Dimens.borderRadius8),
                                margin: const EdgeInsets.only(top: 15),
                                child: LayoutBuilder(
                                  builder: (c, constraints) {
                                    return Signature(
                                        height: 150,
                                        width: constraints.maxWidth,
                                        backgroundColor: Colors.transparent,
                                        controller: _controller);
                                  },
                                ),
                              ),
                              Positioned(
                                  right: 15,
                                  bottom: 15,
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.clear();
                                    },
                                    child: Container(
                                      height: 34,
                                      width: 68,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colours.taskBussiness1),
                                          color: Colours.taskBussiness2,
                                          borderRadius: Dimens.borderRadius6),
                                      alignment: Alignment.center,
                                      child: Texts.normalSemiBold('Clear',
                                          color: Colours.taskBussiness1),
                                    ),
                                  ))
                            ],
                          )
                        : const AddPictureWidget(
                            crossAxisCount: 3, picturesCount: 3)
                  ],
                )),
            const Expanded(child: SizedBox()),
            SingleButtonBottom(
              title: 'Confirm Collect',
              onTap: CommonUtils.debounce2(() {
                _showConfirmDialog();
              }),
            )
          ],
        ));
  }

  Widget _orderItem(int pos) {
    bool selected = (pos % 2) == 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Colours.greyF5, borderRadius: Dimens.borderRadius8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Texts.normalSemiBold('BUFZA60221*****YQ',
                  color: Colours.titleColor),
              Texts.normal('PS1234567890', color: Colours.grey63),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                  child: Texts.normal("Est Chg Weight: 2kgCan't fit into bag",
                      color: Colours.titleColor)),
              const SizedBox(width: 10),
              Image.asset(selected ? Res.order_checked : Res.order_unchecked,
                  width: 15, height: 15)
            ],
          )
        ],
      ),
    );
  }

  String _shipperTab = 'HandWriting';

  Widget _shipperTabWidget(String title) {
    bool selected = title == _shipperTab;
    return GestureDetector(
      onTap: () {
        if (selected == title) {
          return;
        }
        setState(() {
          _shipperTab = title;
        });
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: selected ? Colours.taskBussiness1 : Colours.greyF5,
              borderRadius: Dimens.borderRadius6),
          child: Texts.normal(title,
              color: selected ? Colors.white : Colours.grey63)),
    );
  }

  void _showConfirmDialog() {
    DialogUtils.showPrimaryGradientDialog(
        title:
            'This customer still has 3 parcels that have not been picked up. Do you still want to continue picking up these parcel first?',
        negativeText: 'Cancel Pick-Up',
        positiveText: 'Pick Up',
        negativeAction: () {
          _showCancelForReasonDialog();
        });
  }

  // final List<ReasonSelectBean> _notDeliverableReason = [
  //   ReasonSelectBean(title: 'No one at home'),
  //   ReasonSelectBean(title: 'Change of address'),
  //   ReasonSelectBean(title: 'TEL no answer'),
  //   ReasonSelectBean(title: 'Address incorrect'),
  //   ReasonSelectBean(title: 'TEL incorrect'),
  //   ReasonSelectBean(title: 'Client refused to sign'),
  //   ReasonSelectBean(title: 'Client requires reschedule')
  // ];
  //
  // final List<ReasonSelectBean> _wrongPinDropReason = [
  //   ReasonSelectBean(title: 'Parcel Wrongly allocated'),
  //   ReasonSelectBean(title: 'Suburb not matching address')
  // ];
  //
  // final List<ReasonSelectBean> _unfinishedDeliveryReason = [
  //   ReasonSelectBean(title: 'Delivery unfinished'),
  //   ReasonSelectBean(title: 'Vehicle Issues'),
  //   ReasonSelectBean(title: 'Weather Issues'),
  //   ReasonSelectBean(title: 'Road Issues'),
  //   ReasonSelectBean(title: 'Office premises closed')
  // ];

  void _showCancelForReasonDialog() {
    DialogUtils.showBottomSheet(
        isScrollControlled: true,
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 38),
                  Expanded(
                      child: GestureDetector(
                          child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: Texts.largerMedium('Select Cancel Reason',
                        color: Colours.titleColor),
                  ))),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child:
                          Image.asset(Res.file_delete, width: 18, height: 18)),
                  const SizedBox(width: 20)
                ],
              ),
              Container(
                constraints: const BoxConstraints(maxHeight: 400),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(Res.warning, width: 44, height: 44),
                      ),
                      const SizedBox(height: 12),
                      Center(
                          child: Texts.normalSemiBold(
                              '188 unconfirmed parcels will be canceled',
                              color: Colours.taskBussiness1)),
                      const SizedBox(height: 24),
                      // ReasonSelectWidget(
                      //     title: 'Not Deliverable',
                      //     data: _notDeliverableReason),
                      // ReasonSelectWidget(
                      //     title: 'Wrong Pin Drop', data: _wrongPinDropReason),
                      // ReasonSelectWidget(
                      //     title: 'Unfinished Delivery',
                      //     data: _unfinishedDeliveryReason),
                      Row(
                        children: [
                          Texts.normalSemiBold('Upload photos',
                              color: Colours.titleColor),
                          Texts.normal('*', color: Colours.requiredColor)
                        ],
                      ),
                      const AddPictureWidget(
                          crossAxisCount: 3, picturesCount: 3),
                      const SizedBox(height: 15),
                      const Divider(thickness: 0.5),
                      Container(
                        height: 50,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Texts.normalSemiBold('Date',
                                color: Colours.titleColor),
                            const Expanded(child: SizedBox()),
                            Image.asset(Res.arrow_right, width: 18, height: 18)
                          ],
                        ),
                      ),
                      const Divider(thickness: 0.5),
                      const SizedBox(height: 15),
                      Texts.normalSemiBold('Remake', color: Colours.titleColor),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: const BoxDecoration(
                            color: Colours.greyF5,
                            borderRadius: Dimens.borderRadius8),
                        child: const TextField(
                          minLines: 3,
                          maxLines: 99,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '',
                              hintStyle: TextStyle(
                                  fontSize: 16, color: Colours.grey8F)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              TwoButtonBottom(
                  leftWidget:
                      Texts.normalSemiBold('Confirm', color: Colors.white),
                  rightWidget: Texts.normalSemiBold('Cancel',
                      color: Colours.taskBussiness1),
                  onLeftTap: () {},
                  onRightTap: () {
                    Get.back();
                  })
            ],
          ),
        ));
  }
}
