import 'package:courier_app/res/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/base/app_bars.dart';
import '../../widgets/base/cards.dart';
import '../../widgets/base/texts.dart';
import '../../widgets/bottombar/single_button_bottom_bar.dart';

class NotUploadedPage extends StatefulWidget {
  const NotUploadedPage({super.key});

  @override
  State<NotUploadedPage> createState() => _NotUploadedPageState();
}

class _NotUploadedPageState extends State<NotUploadedPage> {
  final List<int> _data = [1, 2, 3, 4, 5, 6];

  final ScrollController _scrollController = ScrollController();

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
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16),
            width: 25.5,
            child: Center(
              child: Texts.normal(
                index.toString(),
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Texts.large(
                  "BUFZA6022131029YQ",
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: Colours.titleColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                Texts.normal(
                  "Central Business District, 91 Plein St, Cape Town City Centre, Cape Town, 8001",
                  color: Colours.grey63,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.white(
        title: "Not uploaded",
      ),
      backgroundColor: const Color(0xffF5F5F5),
      bottomNavigationBar: SingleButtonBottomBar(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        buttonText: "Upload",
        onPressed: () {
          print("click uploaded slide_button");
        },
      ),
      body: _renderPageContent(),
    );
  }

  Widget _renderPageContent() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          height: 84,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Texts.large(
                "999",
                letterSpacing: 0,
                fontWeight: FontWeight.w600,
                color: Colours.titleColor,
              ),
              Texts.normal(
                "Qty",
                letterSpacing: 0,
                color: Colours.grey63,
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            controller: _scrollController,
            itemCount: _data.length + 1,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (BuildContext context, int index) {
              return _renderItem(index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 12,
              );
            },
          ),
        )
      ],
    );
  }
}
