import 'package:courier_app/res/colours.dart';
import 'package:courier_app/utils/date_format_utils.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';

class DateRange extends StatefulWidget {
  final String dateFormat;
  final ValueChanged? onStartDateSelected;
  final ValueChanged? onEndDateSelected;

  const DateRange({
    super.key,
    this.dateFormat = DateFormats.y_mo_d,
    this.onStartDateSelected,
    this.onEndDateSelected,
  });

  @override
  State<StatefulWidget> createState() => _DateRangeState();
}

class _DateRangeState extends State<DateRange> {
  static final BoxDecoration _inkDecoration = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(17)),
    // border: Border.all(color: Colours.scaffoldBackground, width: 0.5),
    // color: Colours.scaffoldBackground,
    border: Border.all(
      width: 1,
      color: const Color(0xffDCDCDC),
    ),
    color: Colors.white,
  );

  static const Color _unDateColor = Colours.grey99;
  static const Color _dateColor = Colours.primaryTextColor;

  static const String _startDatePlaceholder = 'Start Date';
  static const String _endDatePlaceholder = 'End Date';

  String _startDate = '';
  String _endDate = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _renderDateItem(),
      ],
    );
  }

  Widget _renderDateItem() {
    return Row(
      children: [
        Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: const BorderRadius.all(Radius.circular(17)),
          child: Ink(
            width: 120,
            height: 34,
            decoration: _inkDecoration,
            child: InkWell(
              onTap: () {
                _handleSelectDate(true);
              },
              child: Container(
                alignment: Alignment.center,
                child: Texts.small(
                  _startDate.isNotEmpty != true
                      ? _startDatePlaceholder
                      : _startDate,
                  fontWeight: _startDate.isNotEmpty != true
                      ? FontWeight.w400
                      : FontWeight.w500,
                  color:
                      _startDate.isNotEmpty != true ? _unDateColor : _dateColor,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 8,
          height: 0.5,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          color: Colours.grey99,
        ),
        Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: const BorderRadius.all(Radius.circular(17)),
          child: Ink(
            width: 120,
            height: 34,
            decoration: _inkDecoration,
            child: InkWell(
              onTap: () {
                _handleSelectDate(false);
              },
              child: Container(
                alignment: Alignment.center,
                child: Texts.small(
                  _endDate.isNotEmpty != true ? _endDatePlaceholder : _endDate,
                  fontWeight: _endDate.isNotEmpty != true
                      ? FontWeight.w400
                      : FontWeight.w500,
                  color:
                      _endDate.isNotEmpty != true ? _unDateColor : _dateColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 选择时间
  void _handleSelectDate(bool isStartDate) async {
    DateTime currentDate = DateTime.now();
    // 最小日期: 当天往前10年
    var firstDate =
        DateTime(currentDate.year - 10, currentDate.month, currentDate.day);
    // 最大日期: 当天
    var lastDate = currentDate;
    // 当前日期: 当天
    var initialDate = currentDate;
    if (isStartDate) {
      // 开始时间
      // 最小日期: 当天往前10年
      // 最大日期: 当天 / 结束时间
      if (_endDate.isNotEmpty == true) {
        lastDate = DateFormatUtils.from(_endDate, format: widget.dateFormat) ??
            currentDate;
      }
      // 当前日期: 当天 / 开始时间
      if (_startDate.isNotEmpty == true) {
        initialDate =
            DateFormatUtils.from(_startDate, format: widget.dateFormat) ??
                currentDate;
      }
    } else {
      // 结束时间
      // 最小日期: 当天往前10年 / 开始时间
      if (_startDate.isNotEmpty == true) {
        firstDate =
            DateFormatUtils.from(_startDate, format: widget.dateFormat) ??
                currentDate;
      }
      // 最大日期: 当天
      // 当前日期: 当天 / 结束时间
      if (_endDate.isNotEmpty == true) {
        initialDate =
            DateFormatUtils.from(_endDate, format: widget.dateFormat) ??
                currentDate;
      }
    }
    final selectDayTime = await showDatePicker(
      context: context,
      firstDate: firstDate, // 最小日期
      lastDate: lastDate, // 最大日期
      initialDate: initialDate, // 默认时间
    );
    String? timeString =
        DateFormatUtils.formatDate(selectDayTime, format: widget.dateFormat);
    if (isStartDate) {
      _startDate = timeString ?? _startDate;
      widget.onStartDateSelected?.call(_startDate);
    } else {
      _endDate = timeString ?? _endDate;
      widget.onEndDateSelected?.call(_endDate);
    }
    debugPrint('选择时间, 开始时间:$_startDate, 结束时间$_endDate');
    setState(() {});
  }
}
