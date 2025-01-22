import 'package:courier_app/res/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../res.dart';
import '../../res/colours.dart';
import '../../widgets/base/app_bars.dart';
import '../../widgets/base/texts.dart';
import '../../widgets/dashed_border/dashed_border.dart';
import '../tomorrow_delivery_record/widgets/card_widget.dart';
import '../tomorrow_delivery_record/widgets/delivery_type_enum.dart';

class MissionClaimPage extends StatefulWidget {
  const MissionClaimPage({super.key});

  @override
  State<MissionClaimPage> createState() => _MissionClaimPageState();
}

class _MissionClaimPageState extends State<MissionClaimPage> {
  // 菜单控制器
  final MenuController _controller = MenuController();

  final ScrollController _scrollController = ScrollController();

  final List<int> _data = [1, 2, 3, 4, 5];

  // 当前选中项目
  DeliverType _selectedOption = DeliverType.allType;

  // 展开/收起 箭头图标
  String _iconPath = Res.down_arrow;

  void _changeIcon() {
    if (_controller.isOpen) {
      setState(() {
        _iconPath = Res.up_arrow;
      });
    } else {
      setState(() {
        _iconPath = Res.down_arrow;
      });
    }
  }

  _switch() {
    if (_controller.isOpen) {
      _controller.close();
    } else {
      _controller.open();
    }
  }

  _tapDeliveryType(value) {
    setState(() {
      _selectedOption = value;
    });
  }

  // 模拟加载更多数据
  void _loadMore() {
    if (_data.length >= 20) return;

    // 模拟异步加载数据
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        // 加载更多数据
        _data.addAll(List.generate(10, (index) => index));
      });
    });
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // 列表滚动到底部，触发加载更多
        _loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

  Widget _renderItem(int index) {
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Texts.large(
                  "BUFZA6022131029YQ",
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 50,
                height: 20,
                decoration: BoxDecoration(
                  color: Colours.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                // ClipRRect
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colours.primaryColor,
                          ),
                          child: Center(
                            child: Texts.small(
                              "W",
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffF8F3ED),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                            border: Border(
                              top: BorderSide(
                                color: Colours.primaryColor,
                                width: 0.5,
                              ),
                              right: BorderSide(
                                color: Colours.primaryColor,
                                width: 0.5,
                              ),
                              bottom: BorderSide(
                                color: Colours.primaryColor,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Texts.small(
                              "118",
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0,
                              color: Colours.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Texts.normal(
            "Central Business District, 91 Plein St, Cape Town City Centre, Cape Town, 8001",
            letterSpacing: 0,
            color: Colours.titleColor,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: const DashedBorder(),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: Colours.primaryColor,
                borderRadius: BorderRadius.circular(17),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () {
                    print("Accept");
                  },
                  child: Container(
                    height: 34,
                    width: 99,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: Center(
                      child: Texts.large(
                        "Accept",
                        color: Colors.white,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _renderPageContent() {
    return Column(
      children: [
        Container(
          height: 64,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Texts.normal(
                "Geofence：",
                color: Colours.titleColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
              MenuAnchor(
                controller: _controller,
                onOpen: _changeIcon,
                onClose: _changeIcon,
                builder: (BuildContext context, MenuController controller,
                    Widget? child) {
                  return Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(34),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: _switch,
                      child: Container(
                        height: 34,
                        width: 130,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(34),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xffDCDCDC),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Texts.small(
                              _selectedOption.label.toString(),
                              color: Colours.titleColor,
                              letterSpacing: 0,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              _iconPath,
                              width: 16,
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                menuChildren: DeliverType.values.map((DeliverType value) {
                  return MenuItemButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size(130, 44),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        _selectedOption == value
                            ? const Color(0xffF8F3ED)
                            : Colors.white,
                      ),
                    ),
                    onPressed: () {
                      _tapDeliveryType(value);
                    },
                    child: _selectedOption == value
                        ? Texts.normal(
                            value.label,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                            color: Colours.primaryColor,
                          )
                        : Texts.normal(
                            value.label,
                            letterSpacing: 0,
                            color: Colours.titleColor,
                          ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardWidget(
                    title: 'Task',
                    num: 45,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  CardWidget(
                    title: 'Orders',
                    num: 42,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (BuildContext context, int index) {
              return _renderItem(index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 12,
              );
            },
            itemCount: _data.length + 1,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.white(
        title: "Mission Claim",
      ),
      backgroundColor: const Color(0xffF5F5F5),
      body: _renderPageContent(),
    );
  }
}
