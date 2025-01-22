import 'package:courier_app/res/colours.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../res.dart';
import '../../../utils/dialog_utils.dart';
import '../../../widgets/dashed_border/dashed_border.dart';

class InvitationCode extends StatelessWidget {
  const InvitationCode({super.key});

  final String code = "549067845607";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Texts.small(
              "Invitation Code：",
              fontWeight: FontWeight.w600,
              color: Colours.grey63,
              letterSpacing: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Texts.normal(
                  code,
                  fontWeight: FontWeight.w600,
                  color: Colours.titleColor,
                  letterSpacing: 0,
                ),
                const SizedBox(
                  width: 10,
                ),
                Material(
                  child: InkWell(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: code));
                      DialogUtils.showToast('Copy Success');
                    },
                    child: Image.asset(
                      Res.copy,
                      width: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const DashedBorder(),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 10),
            child: Texts.small(
              "Invitation URL：",
              color: Colours.grey63,
              letterSpacing: 0,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Texts.small(
                  "Http：192.168.0.221：6019/client/login?invitationcode=IC9324346790",
                  color: Colours.titleColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Material(
                child: InkWell(
                  child: Image.asset(
                    Res.copy,
                    width: 16,
                  ),
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: code));
                    DialogUtils.showToast('Copy Success');
                  },
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffF8F3ED),
              borderRadius: BorderRadius.circular(8),
            ),
            height: 94,
            width: 94,
            child: Center(
              child: Image.network(
                width: 86,
                height: 86,
                "https://rookie-files.oss-cn-shanghai.aliyuncs.com/girl.jpg",
              ),
            ),
          )
        ],
      ),
    );
  }
}
