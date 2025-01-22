import 'package:flutter/material.dart';

abstract class TextStyles {
  /// 20号字体
  static const largest = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  /// 18号字体
  static const larger = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  /// 16号字体
  static const large = TextStyle(
    fontSize: 16,
    height: 1.3,
    fontWeight: FontWeight.w400,
  );

  static const largeSemiBold = TextStyle(
    fontSize: 16,
    height: 1.3,
    fontWeight: FontWeight.w600,
  );

  /// 14号字体
  static const normal = TextStyle(
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w400,
  );

  static const normalMedium = TextStyle(
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w500,
  );

  static const normalSemiBold = TextStyle(
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w600,
  );

  static const normalBold = TextStyle(
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w700,
  );

  /// 12号字体
  static const small = TextStyle(
    fontSize: 12,
    height: 1.3,
    fontWeight: FontWeight.w400,
  );

  /// 11号字体
  static const smallest = TextStyle(
    fontSize: 11,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );

  static const smallestMedium = TextStyle(
    fontSize: 11,
    height: 1.4,
    fontWeight: FontWeight.w500,
  );

  static const smallestSemiBold = TextStyle(
    fontSize: 11,
    height: 1.4,
    fontWeight: FontWeight.w600,
  );

  static const smallest1 = TextStyle(
    fontSize: 10,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );
}
