import 'package:courier_app/features/auth/login/login_page.dart';
import 'package:courier_app/helpers/cache_helper.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

import 'dio_configs.dart';

const noLoginStatus = 209;

enum DioType {
  sso,
  api,
  admin,
  uploadFile,
}

class DioFactory {
  factory DioFactory() => _instance;

  static DioFactory get instance => _instance;

  static final DioFactory _instance = DioFactory._();

  static final Map<DioType, Dio> _dioCache = {};

  DioFactory._();

  Dio dio(DioType type) {
    Dio? cached = _dioCache[type];
    if (cached == null) {
      cached = _buildDio(type);

      _dioCache[type] = cached;
    }

    return cached;
  }

  Dio _buildDio(DioType type) {
    BaseOptions baseOptions = _getDioBaseOptions(type);

    Dio dio = Dio(baseOptions);

    _addInterceptor(dio, type);

    _addLogger(dio, type);

    return dio;
  }

  BaseOptions _getDioBaseOptions(DioType type) {
    switch (type) {
      case DioType.sso:
        // sso
        return BaseOptions(
          baseUrl: DioConfigs.ssoBaseUrl,
          connectTimeout: DioConfigs.connectTimeout,
          sendTimeout: DioConfigs.sendTimeout,
          receiveTimeout: DioConfigs.receiveTimeout,
          responseType: ResponseType.json,
        );
      case DioType.api:
        // api
        return BaseOptions(
          baseUrl: DioConfigs.apiBaseUrl,
          connectTimeout: DioConfigs.connectTimeout,
          sendTimeout: DioConfigs.sendTimeout,
          receiveTimeout: DioConfigs.receiveTimeout,
          responseType: ResponseType.json,
        );
      case DioType.admin:
        // admin
        return BaseOptions(
          baseUrl: DioConfigs.adminBaseUrl,
          connectTimeout: DioConfigs.connectTimeout,
          sendTimeout: DioConfigs.sendTimeout,
          receiveTimeout: DioConfigs.receiveTimeout,
          responseType: ResponseType.json,
        );
      case DioType.uploadFile:
        // uploadFile
        return BaseOptions(
          baseUrl: DioConfigs.uploadFileBaseUrl,
          connectTimeout: DioConfigs.connectTimeout,
          sendTimeout: DioConfigs.sendTimeout,
          receiveTimeout: DioConfigs.receiveTimeout,
          responseType: ResponseType.json,
        );
      default:
        // api
        return BaseOptions(
          baseUrl: DioConfigs.apiBaseUrl,
          connectTimeout: DioConfigs.connectTimeout,
          sendTimeout: DioConfigs.sendTimeout,
          receiveTimeout: DioConfigs.receiveTimeout,
          responseType: ResponseType.json,
        );
    }
  }

  void _addInterceptor(Dio dio, DioType type) {
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        // 请求拦截
        onRequest: _onRequestInterceptor,
        // 请求结果拦截
        onResponse: _onResponseInterceptor,
        // 请求错误拦截
        onError: _onErrorInterceptor,
      ),
    );
  }

  void _onRequestInterceptor(options, handler) async {
    // 设置UA
    options.headers["User-Agent"] = await userAgent();

    // 设置ticket
    final String? ticket = CacheHelper.ticket;
    if (ticket?.isNotEmpty == true) {
      options.headers["Cookie"] = "JSESSIONID=$ticket";
    }

    handler.next(options);
  }

  void _onResponseInterceptor(response, handler) async {
    final responseData = response.data;
    final status = responseData['status'] ?? '';
    if (status == noLoginStatus) {
      // 清除缓存
      CacheHelper.clearAll();
      // 未登录, 拦截
      NavUtils.offAll(const LoginPage());
      // TODO: WAIT 是否在此处将loading消失, 然后return
    }

    handler.next(response);
  }

  void _onErrorInterceptor(error, handler) async {
    // final response = error.response;
    // if (response?.statusCode == HttpStatus.unauthorized) {
    //   if (kDebugMode) debugPrint('没有权限了: ${response?.data}');
    //
    //   // 清除缓存数据
    //   CacheHelper.clearAll();
    //
    //   final data = response?.data;
    //   if (data != null) {
    //     if (data is Map<String, dynamic>) {
    //       if (data['code'] == '3000012') {
    //         // 3000012: 未登录
    //         String? message = data['message'];
    //         if (message != null) {
    //           DialogUtils.showErrorToast(message);
    //         }
    //       }
    //     }
    //   }
    //
    //   NavUtils.offAll(const LoginPage());
    // }
    handler.next(error);
  }

  void _addLogger(Dio dio, DioType type) {
    if (kDebugMode) {
      // 调试控制台输出
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          queryParameters: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          showProcessingTime: true,
          // logPrint: log,
          canShowLog: true,
          showCUrl: true,
          convertFormData: true,
        ),
      );
    }
  }
}
