import 'package:courier_app/api/api_factory.dart';
import 'package:courier_app/api/model/dispatch_detail/reason_section.dart';
import 'package:courier_app/features/dispatch_detail/providers/dispatch_detail_provider.dart';
import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/dimens.dart';
import 'package:courier_app/utils/dialog_utils.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:courier_app/widgets/add_picture/add_picture_widget.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:courier_app/widgets/bottombutton/two_button_bottom.dart';
import 'package:courier_app/features/dispatch_detail/widgets/reason_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReturnBottomSheet {
  static Future<T?> show<T>() async {
    // 获取原因数据
    final reasonData = await ApiFactory.instance.dispatchApi.getReturnReason();
    final datas = reasonData['datas'];
    final reasonList = [];
    for (int i = 0; i < datas.length; i++) {
      final parentItem = datas[i];
      if (parentItem['pid'] == 0) {
        final children = [];
        for (int j = 0; j < datas.length; j++) {
          final childItem = datas[j];
          if (childItem['pid'] == parentItem['id']) {
            children.add(childItem);
          }
        }
        parentItem['children'] = children;
        reasonList.add(ReasonSection.fromJson(parentItem));
      }
    }

    // 图片控制器
    AddPicturesController picturesController = AddPicturesController();

    return DialogUtils.showBottomSheet(
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
                      child: Texts.largerMedium(
                        'Reason for return',
                        color: Colours.titleColor,
                      ),
                    ),
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
              constraints: const BoxConstraints(maxHeight: 400),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 原因选项
                    for (ReasonSection reasonSection in reasonList)
                      ReasonSelect(reasonSection: reasonSection),
                    // 辅助内容
                    Consumer(
                      builder: (context, ref, _) {
                        final selectedOption =
                            ref.watch(selectedReturnReasonOptionProvider);
                        return Column(
                          children: [
                            if (selectedOption?.image == 1)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Texts.normalMedium('Upload photos',
                                          color: Colours.titleColor),
                                      Texts.normal('*',
                                          color: Colours.requiredColor)
                                    ],
                                  ),
                                  AddPictureWidget(
                                    crossAxisCount: 3,
                                    picturesCount: 3,
                                    controller: picturesController,
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            Column(
                              children: [
                                const Divider(thickness: 0.5),
                                Container(
                                  height: 50,
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Texts.normalMedium('Date',
                                            color: Colours.titleColor),
                                      ),
                                      Image.asset(Res.arrow_right,
                                          width: 18, height: 18)
                                    ],
                                  ),
                                ),
                                const Divider(thickness: 0.5),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    Texts.normalMedium('Remark', color: Colours.titleColor),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: const BoxDecoration(
                        color: Colours.greyF5,
                        borderRadius: Dimens.borderRadius8,
                      ),
                      child: const TextField(
                        minLines: 3,
                        maxLines: 99,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '',
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colours.grey8F),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            TwoButtonBottom(
              leftWidget: Texts.normalSemiBold('Confirm', color: Colors.white),
              rightWidget:
                  Texts.normalSemiBold('Cancel', color: Colours.taskBussiness1),
              onLeftTap: () {},
              onRightTap: () {
                NavUtils.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
