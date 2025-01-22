import 'package:courier_app/ext/string_ext.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/services.dart';

/// 限制TextField最大值输入
class MaxInputFormatter extends TextInputFormatter {
  final Decimal max;

  MaxInputFormatter({
    required this.max,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.toDecimal() > max) {
      return oldValue;
    } else {
      return newValue;
    }
  }
}
