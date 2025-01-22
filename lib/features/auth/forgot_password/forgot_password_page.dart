import 'package:courier_app/api/api_factory.dart';
import 'package:courier_app/features/auth/forgot_password/update_password_success.dart';
import 'package:courier_app/inputformatter/ignore_other_input_formatter.dart';
import 'package:courier_app/utils/api_utils.dart';
import 'package:courier_app/utils/common_utils.dart';
import 'package:courier_app/utils/dialog_utils.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:courier_app/utils/utils.dart';
import 'package:courier_app/widgets/base/app_bars.dart';
import 'package:courier_app/widgets/bottombar/single_button_bottom_bar.dart';
import 'package:courier_app/widgets/form/constants/form_constants.dart';
import 'package:courier_app/widgets/form/form_item.dart';
import 'package:flutter/material.dart';

// TODO: NEXT 忘记密码暂时不做

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // 表单校验
  final _formKey = GlobalKey<FormState>();

  // 邮箱输入
  final TextEditingController _emailController = TextEditingController();
  // 验证码输入
  final TextEditingController _verifyController = TextEditingController();
  // 新密码输入
  final TextEditingController _passwordController = TextEditingController();
  // 确认密码输入
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // 是否成功修改
  bool _isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.white(title: 'Forgot password'),
      bottomNavigationBar: _isSuccess
          ? null
          : SingleButtonBottomBar(
              buttonText: 'Save Password',
              onPressed: CommonUtils.debounce2(() {
                _handleConfirm();
              }),
            ),
      body: _renderPageContent(),
    );
  }

  Widget _renderPageContent() {
    return SizedBox(
      child: ListView(
        children: [
          _isSuccess
              ? UpdatePasswordSuccess(
                  noteDesc: 'Password has been reset',
                  actionDesc: 'Return to login page',
                  actionOnTap: () {
                    _handleBackLogin();
                  },
                )
              : Column(
                  children: [
                    _renderFormList(),
                    // 屏蔽邮箱获取验证码的方式
                    // _renderChangeVerifyType(),
                  ],
                )
        ],
      ),
    );
  }

  // 表单组件
  Widget _renderFormList() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            // 邮箱
            FormItem(
              formType: FormType.inputNormal,
              formTitle: 'Email',
              placeholder: 'Email',
              iController: _emailController,
              iKeyboardType: TextInputType.emailAddress,
              iFormatters: [IgnoreOtherInputFormatter()],
              bottomGap: 16,
            ),
            // 验证码
            FormItem(
              formType: FormType.inputVerifyCode,
              formTitle: 'Verification code',
              placeholder: 'Verification code',
              iController: _verifyController,
              iFormatters: [IgnoreOtherInputFormatter()],
              bottomGap: 16,
              iVerifyCodeOnTap: () async {
                await _handleGetVerificationCode();
              },
            ),
            // 新密码
            FormItem(
              formType: FormType.inputPassword,
              formTitle: 'New password',
              placeholder: 'Password',
              iController: _passwordController,
              iFormatters: [IgnoreOtherInputFormatter()],
              bottomGap: 16,
            ),
            // 确认密码
            FormItem(
              formType: FormType.inputPassword,
              formTitle: 'Confirm password',
              placeholder: 'Password',
              iController: _confirmPasswordController,
              iFormatters: [IgnoreOtherInputFormatter()],
              bottomGap: 16,
            ),
          ],
        ),
      ),
    );
  }

  // 表单验证
  // onGetCode: true: 点击验证码, false: 点击登录
  // checkForm: 是否需要校验表单
  String? _checkForm(bool onGetCode, bool checkForm) {
    if (onGetCode) {
      // 邮箱校验
      if (!(Utils.validateEmail(_emailController.text))) {
        DialogUtils.showToast('Wrong Email format.');
        return 'Wrong Email format.';
      }
    }
    if (checkForm) {
      if (_verifyController.text.isEmpty) {
        DialogUtils.showToast('Wrong Email code.');
        return 'Wrong Email code.';
      }
      if (_passwordController.text.isEmpty) {
        DialogUtils.showToast('Please enter new password.');
        return 'Please enter new password.';
      }
      if (_confirmPasswordController.text.isEmpty) {
        DialogUtils.showToast('Please enter confirm password.');
        return 'Please enter confirm password.';
      }
      if (_passwordController.text != _confirmPasswordController.text) {
        DialogUtils.showToast('Inconsistent Password.');
        return 'Inconsistent Password.';
      }
    }
    return null;
  }

  // 获取验证码
  Future _handleGetVerificationCode() async {
    debugPrint('忘记密码-获取验证码');
    FocusManager.instance.primaryFocus?.unfocus();
    String? exString = _checkForm(true, false);
    if (exString != null) {
      throw Exception(exString);
    }
    try {
      DialogUtils.showLoading();
      final response = await ApiFactory.instance.userApi.sendEmailCode(
        email: _emailController.text,
      );
      debugPrint('get code email: $response');
      DialogUtils.hideLoading();
    } catch (err) {
      debugPrint('获取验证码失败-请求: $err');
      DialogUtils.hideLoading();
      DialogUtils.showErrorToast(err.toString());
      throw Exception(err);
    }
  }

  // 提交
  Future<void> _handleConfirm() async {
    debugPrint('忘记密码-提交');
    FocusManager.instance.primaryFocus?.unfocus();
    String? exString = _checkForm(true, true);
    if (exString != null) {
      return;
    }

    // 发起请求
    ApiUtils.handleSubmit(apiCall: () async {
      final checkResp = await ApiFactory.instance.userApi.checkEmailCode(
        email: _emailController.text,
        code: _verifyController.text,
      );
      debugPrint('忘记密码-校验成功: $checkResp');
      final verifyCode = checkResp['verifycode'];

      final response = await ApiFactory.instance.userApi.updatePassword(
        email: _emailController.text,
        code: verifyCode,
        password: _passwordController.text,
      );
      debugPrint('忘记密码-修改成功: $response');
      _isSuccess = true;
      setState(() {});
    });
  }

  // 忘记密码 - 返回Login界面
  void _handleBackLogin() {
    debugPrint('忘记密码-成功-返回上界面');
    NavUtils.back();
  }
}
