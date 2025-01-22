import 'dart:async';

import 'package:courier_app/features/home/providers/courier_provider.dart';
import 'package:courier_app/features/home/widgets/home_functions.dart';
import 'package:courier_app/features/home/widgets/home_userInfo.dart';
import 'package:courier_app/features/home/widgets/order_management.dart';
import 'package:courier_app/widgets/scaffold/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../res.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  // 下拉刷新
  Future<void> _refreshHome() async {
    ref.invalidate(courierProvider);
  }

  // Future<void> _getCourierInfo() async {
  //   try {
  //     CourierInfo data = await ApiFactory.instance.courierApi.getCourierInfo();
  //
  //     print(data);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(courierProvider);
    return GradientScaffold(
      includeAppBar: false,
      bgImageName: Res.home_bg,
      body: _renderPageContent(),
    );
  }

  Widget _renderPageContent() {
    return RefreshIndicator(
      onRefresh: _refreshHome,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          HomeUserInfo(),
          OrderManagement(),
          HomeFunctions(),
        ],
      ),
    );
  }
}
