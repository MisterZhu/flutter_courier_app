import 'package:courier_app/features/bills/widgets/date_range_enum.dart';
import 'package:courier_app/features/bills/widgets/date_range_select.dart';
import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:courier_app/widgets/scaffold/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  DateRangeLabel _selectedOption = DateRangeLabel.dateRangeOne;

  // 选择开始时间的回调函数
  void _onStartDateSelected(start) {
    print("start:" + start);
  }

  // 选择结束时间的回调函数
  void _onEndDateSelected(end) {
    print("end:" + end);
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      showBackground: false,
      backgroundColor: Colors.white,
      body: _renderPageContent(),
      appBarTitle: "Bills",
    );
  }

  Widget _renderPageContent() {
    return Column(
      children: [
        DateRangeSelect(
          selectedOption: _selectedOption,
          changeSelectedOption: (DateRangeLabel value) {
            setState(() {
              _selectedOption = value;
            });
          },
          onStartDateSelected: _onStartDateSelected,
          onEndDateSelected: _onEndDateSelected,
        ),
        Container(
          height: 80,
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          decoration: const BoxDecoration(
            color: Color(0xffF8F3ED),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Res.warning,
                width: 16,
                height: 16,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Texts.normal(
                  "The below amount is the estimated amount, and the final payment is subject to the amount received",
                  letterSpacing: 0,
                  color: Colours.primaryColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(139),
              1: FixedColumnWidth(99),
              2: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  Container(
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Colours.greyF5,
                    ),
                    child: Center(
                      child: Texts.normal(
                        "Order Type",
                        letterSpacing: 0,
                        color: Colours.grey63,
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Colours.greyF5,
                    ),
                    child: Center(
                      child: Texts.normal(
                        "Dispatch",
                        letterSpacing: 0,
                        color: Colours.grey63,
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Colours.greyF5,
                    ),
                    child: Center(
                      child: Texts.normal(
                        "Pick Up",
                        letterSpacing: 0,
                        color: Colours.grey63,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    height: 44,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1.0, color: Colours.greyE7),
                    )),
                    child: Center(
                      child: Texts.normal(
                        "Paid Amount",
                        letterSpacing: 0,
                        color: Colours.grey63,
                      ),
                    ),
                  ),
                  Container(
                    height: 44,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1.0, color: Colours.greyE7),
                    )),
                    child: Center(
                      child: Texts.normal(
                        "9999",
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        color: Colours.titleColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 44,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1.0, color: Colours.greyE7),
                    )),
                    child: Center(
                      child: Texts.normal(
                        "9999",
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        color: Colours.titleColor,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    height: 44,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1.0, color: Colours.greyE7),
                    )),
                    child: Center(
                      child: Texts.normal(
                        "Unpaid Amount",
                        letterSpacing: 0,
                        color: Colours.grey63,
                      ),
                    ),
                  ),
                  Container(
                    height: 44,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1.0, color: Colours.greyE7),
                    )),
                    child: Center(
                      child: Texts.normal(
                        "9999",
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        color: Colours.titleColor,
                      ),
                    ),
                  ),
                  Container(
                    height: 44,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 1.0, color: Colours.greyE7),
                    )),
                    child: Center(
                      child: Texts.normal(
                        "9999",
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        color: Colours.titleColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
