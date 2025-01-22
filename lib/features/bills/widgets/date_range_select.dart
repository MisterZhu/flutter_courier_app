import 'package:courier_app/features/bills/widgets/date.dart';
import 'package:flutter/material.dart';
import '../../../res.dart';
import '../../../res/colours.dart';
import '../../../widgets/base/texts.dart';
import '../../../widgets/date_range/date_range.dart';
import 'date_range_enum.dart';

class DateRangeSelect extends StatefulWidget {
  // 当前选中项目
  final DateRangeLabel selectedOption;

  // 切换选项的回调函数
  final ValueChanged<DateRangeLabel> changeSelectedOption;

  final ValueChanged<dynamic> onStartDateSelected;

  final ValueChanged<dynamic> onEndDateSelected;

  const DateRangeSelect(
      {super.key,
      required this.selectedOption,
      required this.changeSelectedOption,
      required this.onStartDateSelected,
      required this.onEndDateSelected});

  @override
  State<DateRangeSelect> createState() => _DateRangeSelectState();
}

class _DateRangeSelectState extends State<DateRangeSelect> {
  final MenuController _controller = MenuController();
  String _iconPath = Res.down_arrow;

  // 日期范围
  late String _date;

  void _changeDate(DateRangeLabel value) {
    switch (value) {
      case DateRangeLabel.dateRangeOne:
        _date = DateRangeString.today();
      case DateRangeLabel.dateRangeTwo:
        _date = "${DateRangeString.last7days()}～${DateRangeString.today()}";
      case DateRangeLabel.dateRangeThree:
        _date = "${DateRangeString.last30days()}～${DateRangeString.today()}";
      case DateRangeLabel.dateRangeFour:
        _date = "";
    }
  }

  void _changeIcon() {
    if (_controller.isOpen) {
      setState(() {
        _iconPath = Res.up_arrow;
      });
    } else {
      setState(() {
        _iconPath = Res.down_arrow;
      });
    }
  }

  _switch() {
    if (_controller.isOpen) {
      _controller.close();
    } else {
      _controller.open();
    }
  }

  // 点击菜单项 回调函数
  _tapDateRangeLabel(value) {
    _changeDate(value);
    setState(() {
      widget.changeSelectedOption.call(value);
    });
    _controller.close();
  }

  @override
  void initState() {
    _changeDate(widget.selectedOption);
    super.initState();
  }

  // 展示选择自定义时间选择模块
  Widget _showCustomDate() {
    if (widget.selectedOption == DateRangeLabel.dateRangeFour) {
      return Container(
        padding: const EdgeInsets.only(left: 15, bottom: 15),
        color: Colors.white,
        child: DateRange(
          onStartDateSelected: widget.onStartDateSelected,
          onEndDateSelected: widget.onEndDateSelected,
        ),
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Texts.normal(
                    "Date：",
                    color: Colours.titleColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                  MenuAnchor(
                    controller: _controller,
                    onOpen: _changeIcon,
                    onClose: _changeIcon,
                    builder: (BuildContext context, MenuController controller,
                        Widget? child) {
                      return Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(34),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: _switch,
                          child: Container(
                            height: 34,
                            width: 130,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(34),
                              border: Border.all(
                                width: 1,
                                color: const Color(0xffDCDCDC),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Texts.small(
                                  widget.selectedOption.label.toString(),
                                  color: Colours.titleColor,
                                  letterSpacing: 0,
                                ),
                                Image.asset(
                                  _iconPath,
                                  width: 16,
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    menuChildren:
                        DateRangeLabel.values.map((DateRangeLabel value) {
                      return MenuItemButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(130, 44),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            widget.selectedOption == value
                                ? const Color(0xffF8F3ED)
                                : Colors.white,
                          ),
                        ),
                        onPressed: () {
                          _tapDateRangeLabel(value);
                        },
                        child: widget.selectedOption == value
                            ? Texts.normal(
                                value.label,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0,
                                color: Colours.primaryColor,
                              )
                            : Texts.normal(
                                value.label,
                                letterSpacing: 0,
                                color: Colours.titleColor,
                              ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              widget.selectedOption != DateRangeLabel.dateRangeFour
                  ? Texts.small(
                      _date,
                      letterSpacing: 0,
                      color: Colours.grey8F,
                    )
                  : const SizedBox()
            ],
          ),
        ),
        _showCustomDate(),
      ],
    );
  }
}
