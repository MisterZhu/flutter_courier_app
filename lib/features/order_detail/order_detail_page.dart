import 'package:courier_app/res/colours.dart';
import 'package:courier_app/widgets/bottombar/single_button_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/base/app_bars.dart';
import '../../widgets/base/cards.dart';
import '../../widgets/base/texts.dart';

// 页面 title 枚举
enum OrderType {
  dispatchDetail(name: "Dispatch Detail"),
  pickUpDetail(name: "Pick Up Detail"),
  tomorrowDispatchDetail(name: "Tomorrow Dispatch Detail"),
  tomorrowPickUpDetail(name: "Tomorrow Pick Up Detail");

  const OrderType({required this.name});

  final String name;
}

class OrderDetail extends StatefulWidget {
  // 页面的标题
  final OrderType title;

  final bool isReceiver;

  final bool showBottomButton;

  final VoidCallback? onClick;

  const OrderDetail(
      {super.key,
      required this.title,
      this.showBottomButton = false,
      this.isReceiver = false,
      this.onClick});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  Widget _renderList(String title, String content) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Texts.normal(
            title,
            color: Colours.titleColor,
            letterSpacing: 0,
          ),
          Container(
            width: 175,
            alignment: Alignment.centerRight,
            child: Texts.normal(
              content,
              textAlign: TextAlign.right,
              color: Colours.titleColor,
              letterSpacing: 0,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.white(
        title: widget.title.name.toString(),
      ),
      bottomNavigationBar: SingleButtonBottomBar(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        buttonText: "Wrongly Assign",
        onPressed: () {
          print("Wrongly Assign");
        },
      ),
      body: Column(
        children: [
          Cards.radius12(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Container(
              width: double.infinity,
              height: 122,
              padding: const EdgeInsets.symmetric(
                vertical: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      width: 44,
                      height: 44,
                      "https://rookie-files.oss-cn-shanghai.aliyuncs.com/girl.jpg",
                    ),
                  ),
                  Texts.large(
                    widget.isReceiver ? "Receiver：" : "Sender: " + "Alice",
                    color: Colours.accountTextColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                  ),
                ],
              ),
            ),
          ),
          Cards.radius12(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 7.5,
              ),
              child: Column(
                children: [
                  _renderList("Order No:", "BUFZA1234567"),
                  _renderList("Sender Number:", "12534"),
                  _renderList("Sender Address:",
                      "6397 Echibini Street Extension 8 Langaville"),
                  _renderList("Create Order Time:", "2020-11-10 10:29"),
                  _renderList("Est Weight:", "2.8Kg"),
                  _renderList("Est Vol:", "2.8Kg"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
