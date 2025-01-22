import 'package:flutter/material.dart';
import '../../widgets/base/app_bars.dart';
import '../../res/colours.dart';
import './widgets/list_card.dart';

class ReturningListPage extends StatefulWidget {
  const ReturningListPage({super.key});

  @override
  State<ReturningListPage> createState() => _ReturningListPageState();
}

class _ReturningListPageState extends State<ReturningListPage> {
  List<CardData> cardList = [];
  bool loading = false;
  final String loadMore = 'LOAD_MORE';

  @override
  void initState() {
    super.initState();
    getCardList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getCardList([String? loadType]) async {
    try {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        if (loadType == loadMore) {
          int lastIndex = cardList.length;
          List.generate(5, (index) {
            setState(() {
              loading = false;
              cardList.add(CardData(
                  lastIndex + index, 'title-$index', 'subTitle-$index'));
            });
          });
        } else {
          cardList.clear();
          int lastIndex = cardList.length;
          List.generate(5, (index) {
            setState(() {
              loading = false;
              cardList.add(CardData(
                  lastIndex + index, 'title-$index', 'subTitle-$index'));
            });
          });
        }
      });
    } catch (e) {
      // React to inability to look up the version
    }
  }

  void loadMoreCardList() {
    getCardList(loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars.white(
          title: "Returning List",
        ),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colours.cardColor,
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        '999',
                        style: TextStyle(
                          fontSize: 20,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'Qty',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPrototypeExtentList(
                      prototypeItem: ListCard(CardData(0, 'title', 'subTitle')),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ListCard(cardList[index]);
                        },
                        // Builds 1000 ListTiles
                        childCount: cardList.length,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class CardData {
  int index = 0;
  String title = '';
  String subTitle = '';
  CardData(this.index, this.title, this.subTitle);
}
