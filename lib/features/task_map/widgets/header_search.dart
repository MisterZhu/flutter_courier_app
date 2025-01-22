import 'package:courier_app/features/task_map/providers/task_map_provider.dart';
import 'package:courier_app/features/task_search/task_search_page.dart';
import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeaderSearch extends ConsumerWidget {
  const HeaderSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool buttonsVisible = ref.watch(mapButtonsVisbleProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 返回按钮
        InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const SizedBox(
              height: 44.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(Res.map_return), fit: BoxFit.fill)
                ],
              ),
            )),
        const SizedBox(width: 12),
        if (!buttonsVisible)
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 44.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(39)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 17),
                  const SizedBox(
                    width: 22,
                    height: 22,
                    child: Image(image: AssetImage(Res.scan_code))   
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      width: 1.0,
                      height: 16.0,
                      color: Colours.divider,
                    ),
                  ),
                  const Text('Search',
                      style: TextStyle(
                        color: Colours.grey8F,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ))
                ],
              ),
            ),
            onTap: () {
              NavUtils.to(const TaskSearchPage());
            },
          )
      ],
    );
  }
}
