import 'package:courier_app/features/dispatch_record/disptach_record_page.dart';
import 'package:courier_app/features/not_uploaded/not_uploaded_page.dart';
import 'package:flutter/material.dart';

import '../../../res.dart';
import '../../../utils/nav_utils.dart';
import '../../../widgets/base/texts.dart';
import '../../tomorrow_delivery_record/tomorrow_delivery_record_page.dart';
import 'order_management_item.dart';

class OrderManagement extends StatelessWidget {
  final List<OrderManagementItem> boxNum = [
    OrderManagementItem(
      amount: 999,
      title: "Today pick up",
      onClick: () {
        print("Today pick up");
      },
    ),
    OrderManagementItem(
      amount: 999,
      title: "Today dispatch",
      onClick: () {
        print("Today dispatch");
      },
    ),
    OrderManagementItem(
      amount: 999,
      title: "Today pick complete",
      onClick: () {
        NavUtils.to(const DispatchRecord());
      },
    ),
    OrderManagementItem(
      amount: 999,
      title: "Today Signed",
      onClick: () {
        NavUtils.to(const DispatchRecord(
          selectedIndex: 1,
        ));
      },
    ),
    OrderManagementItem(
      amount: 999,
      title: "Tomorrow pick up",
      onClick: () {
        NavUtils.to(const TomorrowDeliveryRecord());
      },
    ),
    OrderManagementItem(
      amount: 999,
      title: "Tomorrow Dispatch",
      onClick: () {
        NavUtils.to(const TomorrowDeliveryRecord(
          selectedIndex: 1,
        ));
        // print("Tomorrow Dispatch");
      },
    ),
    OrderManagementItem(
      amount: 999,
      title: "Not uploaded",
      onClick: () {
        NavUtils.to(const NotUploadedPage());
      },
    ),
  ];

  OrderManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 242,
      margin: const EdgeInsets.only(top: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                Res.order_management_bg,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Texts.large(
                    "Order management",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFF4E6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 12,
                        ),
                        primary: false,
                        crossAxisCount: 4,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1 / 0.9,
                        children: boxNum,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
