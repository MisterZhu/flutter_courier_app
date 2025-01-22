import 'package:flutter/services.dart';

/// 限制TextField小数的输入：只能输入一位小数，且小数点后面只能保留两位
class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newValueText = newValue.text;

    if (newValueText == ".") {
      //第一个数为.
      newValueText = "0.";
    } else if (newValueText.contains(".")) {
      if (newValueText.lastIndexOf(".") != newValueText.indexOf(".")) {
        //输入了2个小数点
        newValueText = newValueText.substring(0, newValueText.lastIndexOf('.'));
      } else if (newValueText.length - 1 - newValueText.indexOf(".") > 2) {
        //输入了1个小数点 小数点后两位
        newValueText = newValueText.substring(0, newValueText.indexOf(".") + 3);
      }
    }

    return TextEditingValue(
      text: newValueText,
      selection: TextSelection.collapsed(offset: newValueText.length),
    );
  }
}
