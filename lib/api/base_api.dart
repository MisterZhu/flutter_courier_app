import 'dart:io';

import 'package:courier_app/network/dio_factory.dart';
import 'package:dio/dio.dart';

import 'model/base/base_api_exception.dart';
import 'model/base/base_api_resp.dart';
import 'model/base/base_api_resp_map.dart';

abstract class BaseApi {
  Future<T> fetchDataFromGet<T>({
    DioType dioType = DioType.api,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required Function buildFunc,
    CancelToken? cancelToken,
  }) async {
    Response response = await DioFactory.instance.dio(dioType).get(path,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
        cancelToken: cancelToken);
    if (response.statusCode == HttpStatus.ok) {
      return _dataAnalysis(dioType, response.data, buildFunc);
    } else {
      throw BaseApiException(
        status: response.statusCode?.toString() ?? '',
        message: response.statusMessage ?? 'Unknown Error',
      );
    }
  }

  Future<T> fetchDataFromPost<T>({
    DioType dioType = DioType.api,
    required String path,
    Map<String, dynamic>? json,
    Map<String, dynamic>? headers,
    required Function buildFunc,
    CancelToken? cancelToken,
    String? contentType,
  }) async {
    Response response = await DioFactory.instance.dio(dioType).post(path,
        data: json,
        options: headers != null || contentType != null
            ? Options(headers: headers, contentType: contentType)
            : null,
        cancelToken: cancelToken);
    if (response.statusCode == HttpStatus.ok) {
      return _dataAnalysis(dioType, response.data, buildFunc);
    } else {
      throw BaseApiException(
        status: response.statusCode?.toString() ?? '',
        message: response.statusMessage ?? 'Unknown Error',
      );
    }
  }

  Future<T> uploadFile<T>({
    DioType dioType = DioType.api,
    required String path,
    required String filePath,
    Map<String, dynamic>? params,
    String? content,
    Map<String, dynamic>? headers,
    required Function buildFunc,
    CancelToken? cancelToken,
  }) async {
    Map<String, dynamic> formDataMap = {
      content ?? 'content': await MultipartFile.fromFile(filePath,
          filename: filePath.split('/').last),
    };
    if (params?.isNotEmpty == true) {
      formDataMap.addAll(params!);
    }
    final formData = FormData.fromMap(formDataMap);
    Response response = await DioFactory.instance.dio(dioType).post(path,
        data: formData,
        options: headers != null ? Options(headers: headers) : null,
        cancelToken: cancelToken);
    if (response.statusCode == HttpStatus.ok) {
      return _dataAnalysis(dioType, response.data, buildFunc);
    } else {
      throw BaseApiException(
        status: response.statusCode?.toString() ?? '',
        message: response.statusMessage ?? 'Unknown Error',
      );
    }
  }

  static dynamic _dataAnalysis(DioType type, responseData, buildFunc) {
    switch (type) {
      case DioType.sso:
        // sso
        return SsoRespMap(SsoResp(responseData, buildFunc)).map();
      case DioType.api:
        // api
        return ApiRespMap(ApiResp(responseData, buildFunc)).map();
      case DioType.admin:
        // admin
        return AdminRespMap(AdminResp(responseData, buildFunc)).map();
      case DioType.uploadFile:
        // uploadFile
        return UploadFileRespMap(UploadFileResp(responseData, buildFunc)).map();
      default:
        // api
        return ApiRespMap(ApiResp(responseData, buildFunc)).map();
    }
  }
}
