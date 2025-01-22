import 'package:flutter/material.dart';

import '../../../res.dart';
import '../../../res/colours.dart';
import '../../base/texts.dart';
import '../constants/form_constants.dart';

class FormOnTap extends StatefulWidget {
  // 是否禁用
  final bool? disable;
  // 标题
  final String? formTitle;
  // 值
  final String? formValue;
  // 占位符
  final String? placeholder;
  // 区域颜色
  final Color? contentBackgroundColor;

  // 选择点击事件
  final FormAsyncVoidCallback? otContentOnTap;

  const FormOnTap({
    super.key,
    this.disable,
    this.formTitle,
    this.formValue,
    this.placeholder,
    this.contentBackgroundColor,
    this.otContentOnTap,
  });

  @override
  State<FormOnTap> createState() => _FormOnTapState();
}

class _FormOnTapState extends State<FormOnTap> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: widget.contentBackgroundColor ?? Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: widget.disable != true
              ? (() async {
                  debugPrint('选择');
                  await widget.otContentOnTap!();
                })
              : null,
          child: Container(
            width: double.infinity,
            height: 49,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _renderValueView(),
                _renderArrowView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderValueView() {
    return widget.formValue?.isNotEmpty != true
        ? Expanded(
            child: Texts.normal(
              widget.placeholder ?? 'Please Select',
              fontWeight: FontWeight.w400,
              color: Colours.grey99,
            ),
          )
        : Expanded(
            child: Texts.normal(
              widget.formValue ?? '',
              fontWeight: FontWeight.w600,
            ),
          );
  }

  Widget _renderArrowView() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Image.asset(
        Res.list_arrow,
        width: 5,
        height: 9,
      ),
    );
  }
}
