import 'package:courier_app/features/dispatch_pick/widgets/SliverPersistentHeaderToBox.dart';
import 'package:courier_app/features/dispatch_pick/widgets/scanned.dart';

import 'package:courier_app/features/dispatch_pick/widgets/unscanned.dart';
import 'package:courier_app/features/tomorrow_delivery_record/widgets/card_widget.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';

import '../../res.dart';
import '../../widgets/base/app_bars.dart';
import '../../widgets/tab_bar_view_control/tab_bar_indicator.dart';

class DispatchPickUpPage extends StatefulWidget {
  const DispatchPickUpPage({super.key});

  @override
  State<DispatchPickUpPage> createState() => _DispatchPickUpPageState();
}

class _DispatchPickUpPageState extends State<DispatchPickUpPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();

  late TabController _tabController;

  final List<String> _tabs = ["Order", "Geofence"];

  @override
  void initState() {
    _textController.addListener(() {
      print(_textController.text);
    });
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  // order
  Widget _renderOrderList() {
    return ListView.builder(
      itemCount: 20,
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Unscanned(
          orderNo: 'BUFZA5020337718YQ',
          onTap: () {
            print("to scan");
          },
        );
      },
    );
  }

  // Geofence
  Widget _rendGeofenceList() {
    return Column(
      children: [
        Container(
          height: 44,
          margin: const EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), // 左上角圆角
              topRight: Radius.circular(8), // 右上角圆角
            ),
            color: Colours.greyF5,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 139,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Texts.normal(
                    "Geofence",
                    color: Colours.grey63,
                    letterSpacing: 0,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Texts.normal(
                    "To Scan",
                    color: Colours.grey63,
                    letterSpacing: 0,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Texts.normal(
                    "Scanned",
                    color: Colours.grey63,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 44,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 139,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Texts.normal(
                            "wes",
                            color: Colours.titleColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Texts.normal(
                            "999",
                            color: Colours.titleColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Texts.normal(
                            "23",
                            color: Colours.titleColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1,
                );
              },
              itemCount: 20),
        ),
      ],
    );
  }

  // tabs
  Widget _renderTabs() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: Container(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          indicator: const TabBarIndicatorDecoration(),
          tabs: _tabs
              .map(
                (v) => Tab(
                  height: 44,
                  child: Texts.normal(
                    v,
                    fontWeight: FontWeight.w600,
                    color: Colours.titleColor,
                    letterSpacing: 0,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  // tabview
  Widget _renderTabBarView() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _renderOrderList(),
                _rendGeofenceList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 顶部可划出屏幕的内容
  Widget _renderTop() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Texts.large(
                  "Order No",
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colours.titleColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colours.greyF5,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        Res.scan_code,
                        width: 24,
                        height: 24,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        height: 16,
                        width: 1,
                        color: Colours.greyE7,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            hintText: 'input orderNo',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Row(
            children: [
              CardWidget(
                title: "To Scan",
                num: 999,
              ),
              SizedBox(
                width: 12,
              ),
              CardWidget(
                title: "To Scan",
                num: 999,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rendPageContent() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: _renderTop(),
          ),
          SliverPersistentHeaderToBox(
            child: _renderTabs(),
          ),
        ];
      },
      body: _renderTabBarView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.white(
        title: 'Dispatch Pick-Courier',
      ),
      backgroundColor: Colours.scaffoldBackground,
      body: _rendPageContent(),
    );
  }
}
