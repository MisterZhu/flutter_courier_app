import 'package:courier_app/api/model/task/task.dart';
import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/res/dimens.dart';
import 'package:courier_app/widgets/base/cards.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class ReceiverCard extends StatefulWidget {
  final Task taskData;
  const ReceiverCard({
    super.key,
    required this.taskData,
  });

  @override
  State<ReceiverCard> createState() => _ReceiverCardState();
}

class _ReceiverCardState extends State<ReceiverCard> {
  @override
  Widget build(BuildContext context) {
    // customertype: 客户类型客户类型(-1 rtc, -3 shein退件, 1 商业件, 5 take a lot)
    String title =
        widget.taskData.customertype == -1 ? 'Sender: ' : 'Receiver: ';
    String name = widget.taskData.receiver ?? '';
    String telephone = widget.taskData.receivertelephone ?? '';
    String address =
        "${widget.taskData.receiveraddress}${widget.taskData.receiveraddress2?.isEmpty != true ? '\n${widget.taskData.receiveraddress2}' : ''}";
    return Cards.radius12(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Texts.normal(title, color: Colours.grey63),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Texts.normalMedium(name, color: Colours.titleColor),
              Texts.normalMedium(telephone, color: Colours.titleColor),
            ],
          ),
          const SizedBox(height: 8),
          Texts.normal('To：', color: Colours.grey63),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Texts.normalMedium(address, color: Colours.titleColor),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  _handleMapNavigation();
                },
                child: Image.asset(Res.local, width: 20, height: 20),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _handlePhoneCall(widget.taskData.receivertelephone ?? '');
                  },
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colours.taskBussiness1, width: 0.5),
                      color: Colours.taskHeavyFreight2,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(22),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Res.phone_call, width: 20, height: 20),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Texts.normalMedium('Phone Call',
                              color: Colours.taskBussiness1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _handleToWhatsApp(widget.taskData.receivertelephone ?? '');
                  },
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colours.whatsAppColor1, width: 0.5),
                      color: Colours.whatsAppColor2,
                      borderRadius: Dimens.borderRadius22,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Res.whats_app, width: 20, height: 20),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Texts.normalMedium(
                            'WhatsApp',
                            color: Colours.whatsAppColor1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handlePhoneCall(String telephone) async {
    final Uri url = Uri.parse("tel:$telephone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Cannot launch phone number');
    }
  }

  void _handleToWhatsApp(String telephone) async {
    String urlStr =
        "https://api.whatsapp.com/send?phone=$telephone&text=[BUFFALO]Your parcel is dispatching by BUFFALO courier, you'll receive it soon.If you are not at your destination, please reply.";
    final Uri url = Uri.parse(urlStr);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Cannot launch whatsapp');
    }
  }

  void _handleMapNavigation() async {
    // TODO: WAIT 获取当前定位
    num startLatitude = -31.20018;
    num startLongitude = 20.966235;
    num endLatitude = -31.237764;
    num endLongitude = 23.833667;
    String urlStr =
        "https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$endLatitude,$endLongitude&travelmode=driving";
    final Uri url = Uri.parse(urlStr);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch map navigation';
    }
  }
}
