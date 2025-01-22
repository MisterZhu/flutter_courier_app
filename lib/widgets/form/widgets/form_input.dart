import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../res.dart';
import '../../../res/colours.dart';
import '../../../res/text_styles.dart';
import '../../../utils/common_utils.dart';
import '../../base/texts.dart';
import '../constants/form_constants.dart';

class FormInput extends StatefulWidget {
  // 表单类型
  final FormType formType;
  // 占位符
  final String? placeholder;
  // 区域颜色
  final Color? contentBackgroundColor;

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

  const FormInput({
    super.key,
    required this.formType,
    this.placeholder,
    this.contentBackgroundColor,
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
  });

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  // 倒计时的计时器。
  Timer? _timer;
  // 倒计时
  final _countdown = 59;
  // 当前倒计时的秒数。
  int _seconds = 59;
  // 当前样式
  Map _verifyStyle = formVerifyAvailableStyle;
  // 当前墨水瓶（`InkWell`）的文本。
  String _verifyStr = 'Get code';
  // 是否展示密码
  bool _isShowPassword = false;

  @override
  void dispose() {
    // 销毁 timer
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // 设置内边距
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      // 设置宽度撑满组件x
      width: double.infinity,
      // 设置高度
      height: 49,
      // 边框设置
      decoration: BoxDecoration(
        // 背景颜色
        color: widget.contentBackgroundColor ?? Colors.white,
        // 设置圆角
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: _renderFormContainer(),
    );
  }

  // 渲染内容
  Widget _renderFormContainer() {
    return Container(
      // 设置宽度撑满组件x
      width: double.infinity,
      // 设置高度
      height: 49,
      // 边框设置
      decoration: BoxDecoration(
        // 背景颜色
        color: widget.contentBackgroundColor ?? Colors.white,
        // 设置圆角
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          _renderFormPrefix(),
          _renderFormInput(),
          _renderFormSuffix(),
        ],
      ),
    );
  }

  Widget _renderFormPrefix() {
    return widget.formType == FormType.inputPhone
        ? SizedBox(
            width: 48,
            height: 24,
            child: Row(
              children: [
                Texts.normal(
                  '+27',
                  fontWeight: FontWeight.w500,
                ),
                Container(
                  width: 1,
                  height: 12,
                  color: Colours.greyE7,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                )
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _renderFormInput() {
    return Expanded(
      child: TextFormField(
        maxLines: 1,
        minLines: 1,
        controller: widget.iController,
        autofocus: widget.iAutofocus,
        focusNode: widget.iFocusNode,
        keyboardType: widget.iKeyboardType,
        inputFormatters: widget.iFormatters,
        maxLength: widget.iMaxLength,
        onChanged: widget.iOnChanged,
        onEditingComplete: widget.iOnEditingComplete,
        onFieldSubmitted: widget.iOnFieldSubmitted,
        obscureText:
            (widget.formType == FormType.inputPassword && !_isShowPassword),
        style: TextStyles.normal.copyWith(
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '', // 不显示统计
          border: InputBorder.none,
          hintText: widget.placeholder ?? 'Please enter',
          hintStyle: TextStyles.normal.copyWith(
            fontWeight: FontWeight.w400,
            color: Colours.grey99,
          ),
        ),
        // 校验用户名,校验成功返回null，失败则返回错误信息
        // validator: (value) {
        //   return value!.trim().isNotEmpty ? null : "Please Enter";
        // },
      ),
    );
  }

  Widget _renderFormSuffix() {
    if (widget.formType == FormType.inputVerifyCode) {
      return Container(
        margin: const EdgeInsets.only(left: 15),
        child: Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: _verifyStyle['backgroundColor'],
          child: InkWell(
            onTap: _timer == null
                // timer为空, 可点击获取倒计时
                ? CommonUtils.debounce2(() async {
                    debugPrint('获取验证码-点击');
                    try {
                      await widget.iVerifyCodeOnTap!();
                      // 创建倒计时
                      _startTimer();
                    } catch (err) {
                      debugPrint('获取验证码异常: $err');
                    }
                  }, 300)
                // timer存在, 则不可点击
                : null,
            child: Container(
              width: 68,
              height: 24,
              alignment: Alignment.center,
              child: Texts.smallest(
                _verifyStr,
                color: _verifyStyle['textColor'],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
    if (widget.formType == FormType.inputPassword) {
      return GestureDetector(
        onTap: () {
          debugPrint('展示/隐藏密码-点击');
          _isShowPassword = !_isShowPassword;
          setState(() {});
        },
        child: Container(
          // color: Colors.red,
          padding: const EdgeInsets.only(left: 15),
          child: Image(
            width: 18,
            height: 18,
            image: _isShowPassword
                ? const AssetImage(Res.hide_password)
                : const AssetImage(Res.show_password),
          ),
        ),
      );
    }
    return const SizedBox();
  }

  /* ------ Timer ------ */
  // 倒计时
  void _startTimer() {
    if (_timer == null) {
      // 开始倒计时时间
      _verifyStr = '59s';
      // 设置不可用样式
      _verifyStyle = formVerifyUnavailableStyle;
      setState(() {});
      // 每一秒执行计时器
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_seconds == 0) {
          // 结束倒计时
          _cancelTimer();
          // 重置时间
          _seconds = _countdown;
          // 设置可用样式
          _verifyStyle = formVerifyAvailableStyle;
          // 设置可用按钮文案
          _verifyStr = 'Get code';
        } else {
          // 减少时间
          _seconds--;
          // 展示剩余秒数
          _verifyStr = '$_seconds' 's';
        }
        setState(() {});
      });
    }
  }

  // 取消倒计时的计时器。
  void _cancelTimer() {
    if (_timer != null) {
      debugPrint('清除timer');
      // 取消计时器。
      _timer?.cancel();
      _timer = null;
    }
  }
}
