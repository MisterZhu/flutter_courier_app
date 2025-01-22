import 'package:courier_app/res/colours.dart';
import 'package:courier_app/widgets/tab_bar_view_control/tab_bar_indicator.dart';
import 'package:flutter/material.dart';

import '../../res/text_styles.dart';

class TabBarViewControl extends StatefulWidget {
  final List<Tab> tabs;
  final List<Widget> children;

  final int initialIndex;
  final double height;
  final ScrollPhysics? physics;
  const TabBarViewControl({
    super.key,
    required this.tabs,
    required this.children,
    this.initialIndex = 0,
    this.height = 35,
    this.physics
  });

  @override
  State<StatefulWidget> createState() => _TabBarViewControlState();
}

class _TabBarViewControlState extends State<TabBarViewControl>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.initialIndex,
      vsync: this,
      length: widget.tabs.length,
    );
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // Your code goes here.
        // To get index of current tab use tabController.index
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.tabs.length == widget.children.length);
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: TabBar(
            labelPadding: EdgeInsets.zero,
            controller: _tabController,
            tabs: widget.tabs,
            labelStyle: TextStyles.normal.copyWith(
              color: Colours.primaryTextColor,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.visible,
            ),
            unselectedLabelStyle: TextStyles.normal.copyWith(
              color: Colours.primaryTextColor,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.visible,
            ),
            indicator: const TabBarIndicatorDecoration(),
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: widget.physics,
            controller: _tabController,
            children: widget.children,
          ),
        )
      ],
    );
  }
}
