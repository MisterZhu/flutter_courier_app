// delivery 类型枚举
enum DeliverType {
  allType(label: 'All', value: 1),
  delayType(label: 'Delay', value: 2),
  assignType(label: 'Assign', value: 3);

  final String label;
  final int value;

  const DeliverType({required this.label, required this.value});
}
