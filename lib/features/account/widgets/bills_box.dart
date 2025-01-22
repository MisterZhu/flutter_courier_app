import 'package:courier_app/features/bills/bills_page.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';

import '../../../res.dart';
import '../../../utils/nav_utils.dart';

class BillBox extends StatelessWidget {
  const BillBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                NavUtils.to(const BillsPage());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Texts.large(
                    "Bills（current month）",
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                    color: Colours.titleColor,
                  ),
                  Image.asset(
                    Res.list_arrow,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Texts.normal(
                "Estimated total revenue",
                letterSpacing: 0,
                color: Colours.titleColor,
              ),
              Texts.large(
                "9999.99",
                letterSpacing: 0,
                fontWeight: FontWeight.w800,
              )
            ],
          ),
        ],
      ),
    );
  }
}
