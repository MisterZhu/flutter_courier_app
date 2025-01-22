import 'package:courier_app/api/base_api.dart';
import 'package:courier_app/network/dio_factory.dart';

class UserApi extends BaseApi {
  // 登录
  Future<dynamic> login({
    required String machineType, // 机型
    required String serialNo, // 序列号
    required String androidVer, // 安卓版本
    required String appVer, // app版本
    required String loginCode, // 账号
    required String password, // 密码
  }) async {
    Map<String, dynamic> parameters = {
      'machine_type': machineType,
      'serialno': serialNo,
      'android_ver': androidVer,
      'app': 'courier',
      'apptype': 'courier',
      'app_ver': appVer,
      'logintype': '1',
      'logincode': loginCode,
      'password': password,
    };
    return fetchDataFromPost(
      dioType: DioType.sso,
      path: '/api1/login',
      json: parameters,
      buildFunc: (e) => e,
    );
  }

  // 获取用户数据
  Future<dynamic> getUserInfo({
    required String ticket, // ticket
    required String serialNo, // 序列号
  }) async {
    Map<String, dynamic> parameters = {
      'app': 'courier',
      'ticket': ticket,
      'timezone': 'GMT+02:00',
      'serialno': serialNo,
    };
    return fetchDataFromGet(
      path: '/android/login/ticket/1',
      queryParameters: parameters,
      buildFunc: (e) => e,
    );
  }

  // 绑定设备
  Future<dynamic> bindDevice({
    required String serialNo, // 序列号
    required String userid, // 用户id
    Map? headers,
  }) async {
    Map<String, dynamic> parameters = {
      'serialno': serialNo,
      'userid': userid,
    };
    return fetchDataFromPost(
      path: '/android/login/binddevice/1',
      json: parameters,
      headers: {...?headers},
      buildFunc: (e) => e,
    );
  }

  // 发送验证码
  Future<dynamic> sendEmailCode({
    required String email, // 邮箱
  }) async {
    Map<String, dynamic> parameters = {
      'email': email,
    };
    return fetchDataFromPost(
      dioType: DioType.sso,
      path: '/code/sendEmailCode',
      json: parameters,
      buildFunc: (e) => e,
    );
  }

  // 校验验证码
  Future<dynamic> checkEmailCode({
    required String email, // 邮箱
    required String code, // 验证码
  }) async {
    Map<String, dynamic> parameters = {
      'email': email,
      'code': code,
    };
    return fetchDataFromPost(
      dioType: DioType.sso,
      path: '/code/checkEmailCode',
      json: parameters,
      buildFunc: (e) => e,
    );
  }

  // 更新密码
  Future<dynamic> updatePassword({
    required String email, // 邮箱
    required String code, // 验证码 - 校验验证码返回的verifycode
    required String password, // 密码
  }) async {
    Map<String, dynamic> parameters = {
      'email': email,
      'code': code,
      'password': password,
    };
    return fetchDataFromPost(
      path: '/api1/forgetpwd/1',
      json: parameters,
      buildFunc: (e) => e,
    );
  }
}
