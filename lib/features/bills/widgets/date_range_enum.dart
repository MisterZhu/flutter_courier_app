// 时间范围枚举
enum DateRangeLabel {
  dateRangeOne(label: 'Today', value: '1'),
  dateRangeTwo(label: 'Last 7 Days', value: '2'),
  dateRangeThree(label: 'Last 30 Days', value: '3'),
  dateRangeFour(label: 'Custom Date', value: '4');

  final String label;
  final String value;

  const DateRangeLabel({required this.label, required this.value});
}
