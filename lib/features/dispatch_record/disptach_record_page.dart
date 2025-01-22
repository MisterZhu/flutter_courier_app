import 'package:flutter/material.dart';

import '../../res.dart';
import '../../res/colours.dart';
import '../../utils/nav_utils.dart';
import '../../widgets/base/app_bars.dart';
import '../../widgets/base/texts.dart';
import '../../widgets/tab_bar_view_control/tab_bar_indicator.dart';
import '../bills/widgets/date_range_enum.dart';
import '../bills/widgets/date_range_select.dart';
import '../order_detail/order_detail_page.dart';
import '../tomorrow_delivery_record/widgets/card_widget.dart';
import 'order_info.dart';

class DispatchRecord extends StatefulWidget {
  final int selectedIndex;

  const DispatchRecord({super.key, this.selectedIndex = 0});

  @override
  State<DispatchRecord> createState() => _DispatchRecordState();
}

class _DispatchRecordState extends State<DispatchRecord>
    with SingleTickerProviderStateMixin {
  DateRangeLabel _selectedOption = DateRangeLabel.dateRangeOne;

  // 选择开始时间的回调函数
  void _onStartDateSelected(start) {
    print("start:" + start);
  }

  // 选择结束时间的回调函数
  void _onEndDateSelected(end) {
    print("end:" + end);
  }

  // 当前选中的tab 0 1
  late int _currentIndex;

  // tab 切换
  final Map<int, String> _tabs = {
    0: "Dispatch",
    1: "Pickup",
  };

  late TabController _tabController;

  // 控制器，用于监听列表滚动事件
  final ScrollController _scrollController = ScrollController();

  // 切换tab 展示的背景图， 默认选中左侧
  late String _listBg;

  final List<int> _data = [1, 2, 3, 4, 5, 6];

  // 滚动监听回调函数
  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // 列表滚动到底部，触发加载更多
      print("load more");
      _loadMore();
    }
  }

  // 构建加载更多的指示器
  Widget _buildLoadMoreIndicator() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: const SizedBox(
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(strokeWidth: 2.0),
      ),
    );
  }

  // 模拟加载更多数据
  void _loadMore() {
    // 模拟异步加载数据
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        // 加载更多数据
        _data.addAll(List.generate(10, (index) => index));
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 切换 tab 背景
  void _changeListBg() {
    if (_currentIndex == 0) {
      setState(() {
        _listBg = Res.selected_left;
      });
    } else {
      setState(() {
        _listBg = Res.selected_right;
      });
    }
  }

  // 激活 tab 底部展示 bar
  // Widget _activeTab(int index) {
  //   if (_currentIndex == index) {
  //     return Container(
  //       height: 2.5,
  //       width: 54,
  //       decoration: const BoxDecoration(
  //         color: Colours.primaryColor,
  //       ),
  //     );
  //   }
  //   return const SizedBox();
  // }

  @override
  void initState() {
    _currentIndex = widget.selectedIndex;
    if (_currentIndex == 0) {
      _listBg = Res.selected_left;
    } else {
      _listBg = Res.selected_right;
    }
    // 添加滚动监听器
    _scrollController.addListener(_onScroll);
    _tabController = TabController(
        length: _tabs.length, vsync: this, initialIndex: _currentIndex);

    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
      _changeListBg();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.white(
        title: "Dispatch Record",
      ),
      body: _renderPageContent(),
    );
    // return GradientScaffold(
    //   includeAppBar: true,
    //   backgroundColor: const Color(0xffF1F0EE),
    //   // bgImageName: Res.delivery_bg,
    //   showBackground: false,
    //   body: _renderPageContent(),
    //   appBarTitle: "Dispatch Record",
    // );
  }

  Widget _renderOrderList() {
    return ListView.builder(
      itemCount: _data.length + 1,
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      itemBuilder: (BuildContext context, int index) {
        if (index == _data.length) {
          if (_data.length < 20) {
            return _buildLoadMoreIndicator();
          } else {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                "no more",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
        }
        return OrderInfo(
          handleTap: () {
            NavUtils.to(const OrderDetail(
              title: OrderType.dispatchDetail,
            ));
          },
        );
      },
    );
  }

  Widget _renderPageContent() {
    return Column(
      children: [
        DateRangeSelect(
          selectedOption: _selectedOption,
          changeSelectedOption: (DateRangeLabel value) {
            setState(() {
              _selectedOption = value;
            });
          },
          onStartDateSelected: _onStartDateSelected,
          onEndDateSelected: _onEndDateSelected,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardWidget(
                    title: 'Delivery Qty',
                    num: 45,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  CardWidget(
                    title: 'Total Weight',
                    num: 42,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: _renderList(),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget _renderList() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
        ),
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFCB9E5F),
                Color(0xFFBC8D4D),
                Color(0xFFBC8D4D),
              ],
              stops: [0.04, 0.23, 0.23],
              // 对应渐变中每个颜色的位置
              transform:
                  GradientRotation(190 * (3.1415926535 / 180)), // 将角度转换为弧度
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 0,
          right: 0,
          child: Image.asset(
            _listBg,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          top: 13,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 44,
            child: TabBar(
              controller: _tabController,
              indicator: const TabBarIndicatorDecoration(),
              tabs: _tabs.keys
                  .map(
                    (index) => Tab(
                      height: 44,
                      child: Container(
                        padding: const EdgeInsets.only(top: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Texts.large(
                              _tabs[index]!,
                              fontWeight: _currentIndex == index
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              letterSpacing: 0,
                              color: _currentIndex == index
                                  ? Colours.primaryColor
                                  : Colors.white,
                            ),
                            // _activeTab(index),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 57),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              _renderOrderList(),
              _renderOrderList(),
            ],
          ),
        ),
      ],
    );
  }
}
