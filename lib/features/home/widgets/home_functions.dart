import 'dart:core';

import 'package:courier_app/features/returning_list/returning_list.page.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../res.dart';
import '../../../utils/nav_utils.dart';
import '../../dispatch_pick/dispatch_pick_page.dart';
import '../../mission_claim/mission_claim_page.dart';
import 'home_function_item.dart';

class HomeFunctions extends StatelessWidget {
  final List<HomeFunctionItem> _items = [
    HomeFunctionItem(
      title: "Dispatch Pick",
      imgPath: Res.dispatch_pick,
      onClick: () {
        NavUtils.to(const DispatchPickUpPage());
      },
    ),
    HomeFunctionItem(
      title: "Returning List",
      imgPath: Res.returning_list,
      onClick: () {
        NavUtils.to(const ReturningListPage());
      },
    ),
    HomeFunctionItem(
      title: "Mission claim",
      imgPath: Res.mission_claim,
      onClick: () {
        NavUtils.to(const MissionClaimPage());
      },
    ),
    HomeFunctionItem(
      title: "Scan",
      imgPath: Res.Scan,
      onClick: () {},
    ),
  ];

  HomeFunctions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 16),
          child: Texts.largest(
            "Function",
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
          ),
        ),
        SizedBox(
          height: 220,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            padding: EdgeInsets.zero,
            mainAxisSpacing: 10,
            crossAxisSpacing: 30,
            crossAxisCount: 3,
            childAspectRatio: 1 / 0.9,
            children: _items,
          ),
        ),
      ],
    );
  }
}
