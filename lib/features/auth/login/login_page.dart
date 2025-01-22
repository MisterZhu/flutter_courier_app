import 'package:courier_app/api/api_factory.dart';
import 'package:courier_app/api/model/base/base_api_exception.dart';
import 'package:courier_app/api/model/user/user.dart';
import 'package:courier_app/features/auth/forgot_password/forgot_password_page.dart';
import 'package:courier_app/features/main/main_page.dart';
import 'package:courier_app/helpers/cache_helper.dart';
import 'package:courier_app/inputformatter/ignore_other_input_formatter.dart';
import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/utils/common_utils.dart';
import 'package:courier_app/utils/device_utils.dart';
import 'package:courier_app/utils/dialog_utils.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:courier_app/widgets/form/constants/form_constants.dart';
import 'package:courier_app/widgets/form/form_item.dart';
import 'package:courier_app/widgets/scaffold/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(includeAppBar: false, body: _renderPageContent());
  }

  Widget _renderPageContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._renderLoginLogo(),
            const SizedBox(height: 24),
            ..._renderLoginForm(),
            ..._renderLoginActions(),
          ],
        ),
      ),
    );
  }

  List<Widget> _renderLoginLogo() {
    const span = TextSpan(children: [
      TextSpan(
        text: 'WELCOME',
        style: TextStyle(
          fontSize: 24,
          height: 1.2,
          color: Color(0xFF1F1F20),
          fontWeight: FontWeight.w900,
        ),
      ),
      TextSpan(
        text: ' DRIVER APP',
        style: TextStyle(
          fontSize: 24,
          height: 1.2,
          color: Colours.primaryColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    ]);
    return const [
      Image(image: AssetImage(Res.login_logo)),
      SizedBox(height: 24),
      Text(
        'HELLO!',
        style: TextStyle(
          fontSize: 34,
          height: 1.3,
          color: Color(0xFF1F1F20),
          fontWeight: FontWeight.w900,
        ),
      ),
      SizedBox(height: 12),
      Text.rich(span)
    ];
  }

  List<Widget> _renderLoginForm() {
    return [
      FormItem(
        formType: FormType.inputNormal,
        formTitle: 'Username',
        iController: _usernameController,
        iFormatters: [IgnoreOtherInputFormatter()],
        bottomGap: 16,
      ),
      FormItem(
        formType: FormType.inputPassword,
        formTitle: 'Password',
        iController: _passwordController,
        iFormatters: [IgnoreOtherInputFormatter()],
        bottomGap: 24,
      ),
    ];
  }

  List<Widget> _renderLoginActions() {
    return [
      // 登录按钮
      SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: CommonUtils.debounce2(() {
            _handleLogin();
          }),
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(335, 49)),
          ),
          child: Texts.larger('Login', fontWeight: FontWeight.w600),
        ),
      ),
      // TODO: NEXT 忘记密码暂时不做
      // Container(
      //   alignment: Alignment.centerRight,
      //   child: TextButton(
      //     onPressed: () {
      //       NavUtils.to(const ForgotPasswordPage());
      //     },
      //     child: Texts.normal('Forgot Password?', color: Colours.grey99),
      //   ),
      // )
    ];
  }

  // 表单校验
  bool _checkForm() {
    if (_usernameController.text.isEmpty) {
      DialogUtils.showToast('Please enter username.');
      return false;
    }
    if (_passwordController.text.isEmpty) {
      DialogUtils.showToast('Please enter password.');
      return false;
    }
    return true;
  }

  void _handleLogin() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!_checkForm()) {
      return;
    }

    _getTicket();
  }

  void _getTicket() async {
    DialogUtils.showLoading();

    // 发起请求
    try {
      final deviceInfo = await DeviceUtils.getAndroidDeviceInfo();
      final packageInfo = await DeviceUtils.getPackageInfo();
      final serialNo = await DeviceUtils.getAndroidId();

      final loginResp = await ApiFactory.instance.userApi.login(
        machineType: deviceInfo.model,
        serialNo: serialNo,
        androidVer: deviceInfo.version.release,
        appVer: packageInfo.version,
        loginCode: _usernameController.text,
        password: _passwordController.text,
      );
      debugPrint('login Data: $loginResp');
      // 获取
      final status = loginResp['status'];
      if (status == '200') {
        _getUserInfo(loginResp, serialNo);
      }
    } catch (error) {
      DialogUtils.hideLoading();
      if (error is SsoException) {
        final status = error.status;
        if (status == '204') {
          // 登录名或密码错误
          DialogUtils.showToast('Wrong username');
        } else if (status == '213') {
          // 登录不存在
          DialogUtils.showToast("Username doesn't exist");
        } else {
          // 其他错误
          DialogUtils.showToast('Invalid');
        }
      } else {
        DialogUtils.showToast(error.toString());
      }
    }
  }

  void _getUserInfo(Map loginResp, String serialNo) async {
    final String ticket = loginResp['st'];

    try {
      final userResp = await ApiFactory.instance.userApi.getUserInfo(
        ticket: ticket,
        serialNo: serialNo,
      );
      DialogUtils.hideLoading();
      debugPrint('login user data: $userResp');
      final status = userResp['status'];
      final message = userResp['message'];
      if (status == 0) {
        // 登录成功
        // final subStatus = userResp['substatus'];
        // if (subStatus == 5001) {
        //   // 用户已经绑定其他设备或者设备已经绑定其他用户，提示message信息
        //   DialogUtils.showPrimaryGradientDialog(
        //     title: message,
        //     positiveText: 'OK',
        //   );
        // } else if (subStatus == 5000) {
        //   // 提示用户需要帮定设置，message为提示信息
        //   DialogUtils.showPrimaryGradientDialog(
        //     title: message,
        //     negativeText: 'Confirm',
        //     negativeAction: () {
        //       // 绑定设备
        //       final user = User.fromJson(userResp);
        //       _bindDevice(serialNo, ticket, user);
        //     },
        //     positiveText: 'Cancel',
        //     positiveAction: () {},
        //   );
        // } else {
        //   // 可以登录 - 保存ticket. 用户数据
        //   final user = User.fromJson(userResp);
        //   _loginSuccess(ticket, user);
        // }

        final user = User.fromJson(userResp);
         _loginSuccess(ticket, user);
      } else {
        // 登录失败
        DialogUtils.showToast(message);
      }
    } catch (error) {
      DialogUtils.hideLoading();
      DialogUtils.showToast(error.toString());
    }
  }

  void _bindDevice(String serialNo, String ticket, User user) async {
    try {
      DialogUtils.showLoading();
      final bindResp = await ApiFactory.instance.userApi.bindDevice(
        serialNo: serialNo,
        userid: '${user.id}',
        headers: {
          'Cookie': "JSESSIONID=$ticket",
        },
      );
      DialogUtils.hideLoading();
      final status = bindResp['status'];
      if (status == 0) {
        // 绑定成功
        _loginSuccess(ticket, user);
      } else {
        // 绑定失败
      }
    } catch (error) {
      DialogUtils.hideLoading();
      DialogUtils.showToast(error.toString());
    }
  }

  void _loginSuccess(String ticket, User user) {
    // 保存ticket数据
    CacheHelper.saveTicket(ticket);
    // 保存user数据
    CacheHelper.saveUser(
      user: user,
      needNotify: true,
    );
    // 返回上界面
    NavUtils.offAll(const MainPage());
  }
}
