import 'package:flutter/services.dart';

const _regExp = r"^[0-9]+$";

// Cellphone
class CellphoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (RegExp(_regExp).firstMatch(newValue.text) != null) {
        return newValue;
      }
      return oldValue;
    }
    return newValue;
  }
}
