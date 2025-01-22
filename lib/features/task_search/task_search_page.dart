import 'package:courier_app/features/task_search/widgets/task_search_field.dart';
import 'package:courier_app/features/task_search/widgets/task_search_result_item.dart';
import 'package:courier_app/res/dimens.dart';
import 'package:courier_app/widgets/base/cards.dart';
import 'package:courier_app/widgets/scaffold/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class TaskSearchPage extends StatefulWidget {
  const TaskSearchPage({super.key});

  @override
  State<TaskSearchPage> createState() => _TaskSearchPageState();
}

class _TaskSearchPageState extends State<TaskSearchPage> {
  final List<Map> _addressList = [
    {"name": "000000222"},
    {"name": "111111"},
    {"name": "222222111"},
    {"name": "333333"},
    {"name": "444444000"},
    {"name": "555555"},
    {"name": "666666555"},
  ];
  List<Map> _searchResult = []; 
  String _searchStr = '';

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      includeAppBar: false,
      body: _renderPageContent(),
    );
  }

  Widget _renderPageContent() {
    return Column(
      children: [
        TaskSearchField(
          searchOnChanged: (val) {
            setState(() {
              _searchStr = val;
              _searchResult = _addressList
                  .where((item) =>
                      item["name"].toLowerCase().contains(val.toLowerCase()))
                  .toList();
            });
          },
        ),
        _renderResultView(),
      ],
    );
  }

  Widget _renderResultView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: Dimens.borderRadius12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < _searchResult.length; i++)
                  TaskSearchResultItem(
                    item: _searchResult[i],
                    searchStr: _searchStr,
                    showDivider: i != (_searchResult.length - 1),
                    onTap: (item) {},
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
