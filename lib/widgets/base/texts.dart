import 'package:flutter/material.dart';

abstract class Texts {
  /// 24号字体
  static Text big(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 24,
        height: 1.2,
        color: color,
        textAlign: textAlign,
        fontWeight: fontWeight ?? FontWeight.w400,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  /// 20号字体
  static Text largest(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 20,
        height: 1.5,
        color: color,
        textAlign: textAlign,
        fontWeight: fontWeight ?? FontWeight.w400,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static Text largestSemiBold(
    String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 20,
        height: 1.5,
        color: color,
        textAlign: textAlign,
        fontWeight: FontWeight.w600,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  /// 18号字体
  static Text larger(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 18,
        color: color,
        textAlign: textAlign,
        fontWeight: fontWeight ?? FontWeight.w400,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static Text largerMedium(
    String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 18,
        color: color,
        textAlign: textAlign,
        fontWeight: FontWeight.w500,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  /// 16号字体
  static Text large(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 16,
        height: 1.3,
        color: color,
        textAlign: textAlign,
        fontWeight: fontWeight ?? FontWeight.w400,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static Text largeMedium(
    String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 16,
        height: 1.3,
        color: color,
        textAlign: textAlign,
        fontWeight: FontWeight.w500,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static Text largeSemiBold(
    String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 16,
        height: 1.3,
        color: color,
        textAlign: textAlign,
        fontWeight: FontWeight.w600,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  /// 14号字体
  static Text normal(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 14,
        height: 1.3,
        color: color,
        textAlign: textAlign,
        fontWeight: fontWeight ?? FontWeight.w400,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static Text normalMedium(
    String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 14,
        height: 1.3,
        color: color,
        textAlign: textAlign,
        fontWeight: FontWeight.w500,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static Text normalSemiBold(
    String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 14,
        height: 1.3,
        color: color,
        textAlign: textAlign,
        fontWeight: FontWeight.w600,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static Text normalBold(
    String text, {
      Color? color,
      TextAlign? textAlign,
      int? maxLines,
      TextOverflow? overflow,
      double? letterSpacing,
      TextDecoration? decoration,
      Color? decorationColor,
    }) =>
    custom(
      text,
      fontSize: 14,
      height: 1.3,
      color: color,
      textAlign: textAlign,
      fontWeight: FontWeight.w700,
      maxLines: maxLines,
      overflow: overflow,
      letterSpacing: letterSpacing,
      decoration: decoration,
      decorationColor: decorationColor,
    );

  /// 13号字体
  static Text norma(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 13,
        height: 1.3,
        color: color,
        textAlign: textAlign,
        fontWeight: fontWeight ?? FontWeight.w400,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  /// 12号字体
  static Text small(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 12,
        height: 1.3,
        color: color,
        textAlign: textAlign,
        fontWeight: fontWeight ?? FontWeight.w400,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static Text smallMedium(
    String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 12,
        height: 1.3,
        color: color,
        textAlign: textAlign,
        fontWeight: FontWeight.w500,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static Text smallBold(
    String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 12,
        height: 1.3,
        color: color,
        textAlign: textAlign,
        fontWeight: FontWeight.w700,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  /// 11号字体
  static Text smallest(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 11,
        height: 1.4,
        color: color,
        textAlign: textAlign,
        fontWeight: fontWeight ?? FontWeight.w400,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static Text smallest1(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      custom(
        text,
        fontSize: 10,
        height: 1.4,
        color: color,
        textAlign: textAlign,
        fontWeight: fontWeight ?? FontWeight.w400,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static Text font9(
      String text, {
        Color? color,
        TextAlign? textAlign,
        FontWeight? fontWeight,
        int? maxLines,
        TextOverflow? overflow,
        double? letterSpacing,
        TextDecoration? decoration,
        Color? decorationColor,
      }) =>
      custom(
        text,
        fontSize: 9,
        height: 1,
        color: color,
        textAlign: textAlign,
        fontWeight: fontWeight ?? FontWeight.w400,
        maxLines: maxLines,
        overflow: overflow,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static Text custom(
    String text, {
    double? fontSize,
    double? height,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
    TextOverflow? overflow,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          height: height,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          overflow: overflow,
          decoration: decoration,
          decorationColor: decorationColor,
        ),
      );
}
