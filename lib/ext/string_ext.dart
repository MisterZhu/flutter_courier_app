import 'package:decimal/decimal.dart';

extension StringExt on String {
  Decimal toDecimal() => Decimal.tryParse(this) ?? Decimal.zero;

  /// 将double类型转换成等价的int类型字符串，转换失败则返回原来的值
  String doubleStrToIntStr() {
    final index = indexOf('.');
    if (index == -1) {
      return this;
    } else {
      if (index == length - 1) {
        return length == 1 ? '0' : substring(0, index);
      } else {
        final dotAfterValue = int.tryParse(substring(index + 1));

        if (dotAfterValue != null) {
          if (dotAfterValue == 0) {
            if (index == 0) {
              return "0";
            } else {
              return substring(0, index);
            }
          } else {
            if (index == 0) {
              return "0$this";
            } else {
              return this;
            }
          }
        } else {
          return this;
        }
      }
    }
  }
}
