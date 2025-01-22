import 'package:flutter/services.dart';

/// 限制TextField输入的值：value>=min && value <=max
class NumberRangeInputFormatter extends TextInputFormatter {
  final int min;
  final int max;
  final bool allowEmpty;

  NumberRangeInputFormatter({
    required this.min,
    required this.max,
    this.allowEmpty = true,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty && allowEmpty) {
      return newValue;
    }

    final newText = int.tryParse(newValue.text);
    if (newText == null || newText < min || newText > max) {
      return oldValue;
    }

    return newValue;
  }
}
