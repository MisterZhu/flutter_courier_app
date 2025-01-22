import 'package:courier_app/debug/debug_page.dart';
import 'package:courier_app/res/environments.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/model/user/courier.dart';
import '../../../res.dart';
import '../../../res/colours.dart';
import '../../../widgets/base/texts.dart';
import '../../../widgets/switch/fswitch.dart';
import '../providers/courier_provider.dart';
import '../providers/home_provider.dart';

class HomeUserInfo extends ConsumerWidget {
  const HomeUserInfo({super.key});

  void _changeDuty(WidgetRef ref) {
    ref.read(dutyProvider.notifier).state = !ref.read(dutyProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDuty = ref.watch(dutyProvider);
    AsyncValue<CourierInfo> courierInfo = ref.read(courierProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(
              width: 44,
              height: 44,
              child: ClipOval(
                child: Image.asset(
                  isDuty ? Res.on_duty : Res.off_duty,
                  width: 44,
                  height: 44,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 44,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Texts.large(
                      "rookie",
                      fontWeight: FontWeight.w600,
                      color: Colours.titleColor,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3.5,
                      ),
                      decoration: BoxDecoration(
                        color: isDuty ? Colours.primaryColor : Colours.greyCC,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Texts.font9(
                        isDuty ? "On Duty" : "Off Duty",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (Environments.debugEntryValid == true)
              IconButton(
                color: const Color(0xFFBC8D4D),
                onPressed: () {
                  NavUtils.to(const DebugPage());
                },
                icon: const Icon(Icons.settings),
              )
          ],
        ),
        FSwitch(
          open: isDuty,
          width: 75,
          height: 34,
          onChanged: (bool value) {
            _changeDuty(ref);
          },
          openColor: Colours.primaryColor,
        ),
      ],
    );
  }
}
