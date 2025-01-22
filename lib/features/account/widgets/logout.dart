import 'package:courier_app/res/colours.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';

import '../../../helpers/cache_helper.dart';
import '../../auth/login/login_page.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            CacheHelper.clearAll();
            NavUtils.offAll(const LoginPage());
          },
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Texts.large(
              "LOG OUT",
              fontWeight: FontWeight.w600,
              color: Colours.titleColor,
              letterSpacing: 0,
            ),
          ),
        ),
      ),
    );
  }
}
