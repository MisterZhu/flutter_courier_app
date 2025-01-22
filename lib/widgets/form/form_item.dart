import 'package:courier_app/widgets/form/widgets/form_input.dart';
import 'package:courier_app/widgets/form/widgets/form_on_tap.dart';
import 'package:courier_app/widgets/form/widgets/form_file_select.dart';
import 'package:courier_app/widgets/form/widgets/from_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/form_constants.dart';

class FormItem extends StatefulWidget {
  /* ------ Base ------ */
  // 表单类型
  final FormType formType;
  // 是否必填 - 只做"*"展示使用
  final bool required;
  // 是否禁用 - 只针对FormType是select的选择禁用
  final bool? disable;
  // 标题
  final String? formTitle;
  // 值
  final String? formValue;
  // 占位符
  final String? placeholder;
  // 区域颜色
  final Color? contentBackgroundColor;
  // 底部间隙
  final double? bottomGap;

  /* ------ Common ------ */
  // 标题Widget
  final Widget? titleWidget;
  // 内容Widget
  final Widget? contentWidget;
  // 底部扩展Widget
  final Widget? bottomExtraWidget;

  /* ------ Input ------ */
  // 输入框内容
  final TextEditingController? iController;
  // 是否默认聚焦
  final bool iAutofocus;
  // 焦点
  final FocusNode? iFocusNode;
  // 键盘类型
  final TextInputType? iKeyboardType;
  // 输入内容校验
  final List<TextInputFormatter>? iFormatters;
  // 最大输入长度
  final int? iMaxLength;
  // 输入变更事件
  final ValueChanged<String>? iOnChanged;
  // 输入完成事件
  final VoidCallback? iOnEditingComplete;
  // 输入点击键盘提交按钮事件
  final ValueChanged<String>? iOnFieldSubmitted;
  // 验证码点击事件
  final FormAsyncVoidCallback? iVerifyCodeOnTap;

  /* ------ Select ------ */
  // 选择点击事件
  final FormAsyncVoidCallback? otContentOnTap;

  /* ------ Upload ------ */
  // 文件格式
  final List<FormFileType>? fsFileTypes;
  // 文件个数限制
  final int? fsMaxCount;
  // 文件大小限制 - byte(字节)
  final double? fsMaxFileSize;
  // 文件异常提示
  final String? fsFileExceptionMessage;
  // 选择钩子
  final FormParameterAsyncDynamicCallback? fsOnSelect;
  // 列表变更钩子
  final ValueChanged<dynamic>? fsOnSelectedFilesChanged;

  /* ------ 构造方法 ------ */
  const FormItem({
    super.key,
    /* ------ Base ------ */
    required this.formType,
    this.required = false,
    this.disable,
    this.formTitle,
    this.formValue,
    this.placeholder,
    this.contentBackgroundColor,
    this.bottomGap,

    /* ------ Common ------ */
    this.titleWidget,
    this.contentWidget,
    this.bottomExtraWidget,

    /* ------ Input ------ */
    this.iController,
    this.iAutofocus = false,
    this.iFocusNode,
    this.iKeyboardType,
    this.iFormatters,
    this.iMaxLength,
    this.iOnChanged,
    this.iOnEditingComplete,
    this.iOnFieldSubmitted,
    this.iVerifyCodeOnTap,

    /* ------ Select ------ */
    this.otContentOnTap,

    /* ------ Upload ------ */
    this.fsFileTypes,
    this.fsMaxCount,
    this.fsMaxFileSize,
    this.fsFileExceptionMessage,
    this.fsOnSelect,
    this.fsOnSelectedFilesChanged,
  });

  @override
  State<FormItem> createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  @override
  void initState() {
    debugPrint('Form Item Init State');
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('Form Item Dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          _renderFormTitle(),
          _renderFormContent(),
          _renderFormBottomExtra(),
          Padding(
            padding: EdgeInsets.only(
              bottom: widget.bottomGap ?? 0,
            ),
          ),
        ],
      ),
    );
  }

  // 渲染标题
  Widget _renderFormTitle() {
    if (widget.titleWidget != null) {
      return widget.titleWidget as Widget;
    }
    return FormTitle(
      formTitle: widget.formTitle,
      required: widget.required,
    );
  }

  // 渲染内容
  Widget _renderFormContent() {
    if (widget.contentWidget != null) {
      return widget.contentWidget as Widget;
    }
    if (widget.formType == FormType.inputNormal ||
        widget.formType == FormType.inputPhone ||
        widget.formType == FormType.inputVerifyCode ||
        widget.formType == FormType.inputPassword) {
      return _renderFormInput();
    }
    if (widget.formType == FormType.onTap) {
      return _renderFormOnTap();
    }
    if (widget.formType == FormType.fileSelect) {
      return _renderFormFileSelect();
    }
    return const SizedBox();
  }

  // 渲染扩展区域
  Widget _renderFormBottomExtra() {
    if (widget.bottomExtraWidget != null) {
      return widget.bottomExtraWidget as Widget;
    }
    return const SizedBox();
  }

  // 渲染Input区域
  Widget _renderFormInput() {
    return FormInput(
      formType: widget.formType,
      placeholder: widget.placeholder,
      contentBackgroundColor: widget.contentBackgroundColor,
      iController: widget.iController,
      iAutofocus: widget.iAutofocus,
      iFocusNode: widget.iFocusNode,
      iKeyboardType: widget.iKeyboardType,
      iFormatters: widget.iFormatters,
      iMaxLength: widget.iMaxLength,
      iOnChanged: widget.iOnChanged,
      iOnEditingComplete: widget.iOnEditingComplete,
      iOnFieldSubmitted: widget.iOnFieldSubmitted,
      iVerifyCodeOnTap: widget.iVerifyCodeOnTap,
    );
  }

  // 渲染Select区域
  Widget _renderFormOnTap() {
    return FormOnTap(
      disable: widget.disable,
      formTitle: widget.formTitle,
      formValue: widget.formValue,
      placeholder: widget.placeholder,
      contentBackgroundColor: widget.contentBackgroundColor,
      otContentOnTap: widget.otContentOnTap,
    );
  }

  // 渲染Upload区域
  Widget _renderFormFileSelect() {
    return FormFileSelect(
      fsFileTypes: widget.fsFileTypes,
      fsMaxCount: widget.fsMaxCount,
      fsMaxFileSize: widget.fsMaxFileSize,
      fsFileExceptionMessage: widget.fsFileExceptionMessage,
      fsOnSelect: widget.fsOnSelect,
      fsOnSelectedFilesChanged: widget.fsOnSelectedFilesChanged,
    );
  }
}
