import 'package:flutter/material.dart';

import '../../../res/colours.dart';

// Form类型枚举
enum FormType {
  inputNormal(1, 'InputNormal'),
  inputPhone(2, 'InputPhone'),
  inputVerifyCode(3, 'InputVerifyCode'),
  inputPassword(4, 'InputPassword'),
  onTap(5, 'OnTap'),
  fileSelect(6, 'FileSelect'),
  ;

  final int number;
  final String value;
  const FormType(this.number, this.value);
}

// Form File资源类型枚举
enum FormFileSourceType {
  library(1, 'Library'),
  camera(2, 'Camera'),
  files(3, 'Files'),
  ;

  final int number;
  final String value;
  const FormFileSourceType(this.number, this.value);
}

// FormFile类型枚举
enum FormFileType {
  imagePng(1, 'image/png'),
  imageJpg(2, 'image/jpg'),
  imageJpeg(3, 'image/jpeg'),
  ;

  final int number;
  final String value;
  const FormFileType(this.number, this.value);
}

// 可用样式
Map formVerifyAvailableStyle = {
  'backgroundColor': Colours.primaryColor,
  'textColor': Colors.white,
};
// 不可用样式
Map formVerifyUnavailableStyle = {
  'backgroundColor': Colours.greyCC,
  'textColor': Colors.white,
};

// 回调函数定义
typedef FormAsyncVoidCallback = Future<void> Function();
typedef FormParameterAsyncDynamicCallback = Future<dynamic> Function(
    dynamic parameter);
