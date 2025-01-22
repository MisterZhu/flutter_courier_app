import 'package:courier_app/features/returning_list/returning_list.page.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/widgets/dashed_border/dashed_border.dart';
import 'package:flutter/material.dart';
import '../../../widgets/base/texts.dart';

class ListCard extends StatelessWidget {
  final CardData data;
  const ListCard(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colours.cardColor,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Texts.normalSemiBold('da-${data.index}'),
                  // 占位
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts.largeSemiBold(data.title),
                        Text(
                            'Central Business District, 91 Plein St, Cape Town City Centre, Cape Town, 8001-${data.subTitle}'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const DashedBorder(width: 1),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 12),
              child: ElevatedButton(
                onPressed: () {
                  print('test release11');
                },
                style: ButtonStyle(
                    // padding: MaterialStateProperty(Padding:),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)))),
                child: const Text('Release'),
              ),
            ),
          ],
        ));
  }
}
