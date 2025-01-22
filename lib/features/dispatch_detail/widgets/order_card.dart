import 'package:courier_app/api/model/task/task.dart';
import 'package:courier_app/features/scan/scan_code_page.dart';
import 'package:courier_app/inputformatter/ignore_other_input_formatter.dart';
import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/dimens.dart';
import 'package:courier_app/utils/dialog_utils.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:courier_app/widgets/add_picture/add_picture_widget.dart';
import 'package:courier_app/widgets/base/cards.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scankit/flutter_scankit.dart';
import 'package:pda_barcode_scan/barcode_scan_util.dart';

class OrderCard extends StatefulWidget {
  final Task taskData;
  final TextEditingController orderNoController;
  final AddPicturesController picturesController;
  const OrderCard({
    super.key,
    required this.taskData,
    required this.orderNoController,
    required this.picturesController,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  final List<String> _signedByList = [
    'Receiver',
    'Family Member',
    'Guard',
    'Reception',
  ];
  String _signedByValue = 'Receiver';

  @override
  void initState() {
    // 监听红外扫描
    BarcodeScanUtil.instance.listen((value) {
      print('Pda Scan result: $value');
    });
    super.initState();
  }

  @override
  void dispose() {
    // 销毁红外扫描
    BarcodeScanUtil.instance.cancel();
    debugPrint('Pda Scan dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List data = [
      {'title': 'Order No：', 'value': widget.taskData.orderno},
      {
        'title': 'Weight：',
        'value': '${(widget.taskData.weight ?? 0).toStringAsFixed(2)}KG'
      },
    ];
    // customertype: 客户类型(-1 rtc, -3 shein退件, 1 商业件, 5 take a lot)
    if (widget.taskData.customertype == 5) {
      data.add({'title': 'Date of Booking：', 'value': widget.taskData.booking});
      data.add({'title': 'SLOT Time：', 'value': widget.taskData.slottime});
    }

    return Cards.radius12(
      padding: const EdgeInsets.only(top: 9, bottom: 15, right: 15, left: 15),
      margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...data.map((e) => _itemWidget(e['title'], e['value'])),
          GestureDetector(
            onTap: () {
              _signedBy();
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Texts.normal('Signed By：', color: Colours.titleColor),
                  Expanded(
                    child: Texts.normalMedium(
                      textAlign: TextAlign.end,
                      _signedByValue,
                      color: Colours.titleColor,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Image.asset(Res.arrow_right, width: 20, height: 20)
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: const BoxDecoration(
                    color: Colours.greyF5,
                    borderRadius: Dimens.borderRadius8,
                  ),
                  child: TextField(
                    maxLines: 1,
                    controller: widget.orderNoController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Order No',
                      hintStyle: TextStyle(fontSize: 16, color: Colours.grey8F),
                    ),
                    inputFormatters: [IgnoreOtherInputFormatter()],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  _handleScan();
                },
                child: Image.asset(Res.scan_code, width: 24, height: 24),
              ),
            ],
          ),
          AddPictureWidget(
            crossAxisCount: 3,
            picturesCount: 3,
            controller: widget.picturesController,
          ),
        ],
      ),
    );
  }

  Widget _itemWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Texts.normal(title, color: Colours.grey63),
          Texts.normalMedium(value, color: Colours.titleColor)
        ],
      ),
    );
  }

  void _signedBy() {
    DialogUtils.showBottomSheet(
        isScrollControlled: true,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const SizedBox(width: 38),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: Texts.largerMedium('Signed By',
                        color: Colours.titleColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    NavUtils.back();
                  },
                  child: Image.asset(Res.file_delete, width: 18, height: 18),
                ),
                const SizedBox(width: 20)
              ],
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                itemBuilder: (c, i) {
                  return _signedByWidget(_signedByList[i]);
                },
                itemCount: _signedByList.length,
              ),
            )
          ],
        ));
  }

  Widget _signedByWidget(String value) {
    return GestureDetector(
      onTap: () {
        if (value == _signedByValue) {
          return;
        }
        setState(() {
          _signedByValue = value;
        });
        NavUtils.back();
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Texts.normal(
                      value,
                      color: value == _signedByValue
                          ? Colours.taskBussiness1
                          : Colours.titleColor,
                    ),
                  ),
                  value == _signedByValue
                      ? const Icon(Icons.check, color: Colours.taskBussiness1)
                      : Container(),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            const Divider(
              thickness: 0.5,
            )
          ],
        ),
      ),
    );
  }

  void _handleScan() {
    NavUtils.to(ScanCodePage(
      scanOnResult: (ScanResult res) {
        widget.orderNoController.text = res.originalValue;
      },
    ));
  }
}
