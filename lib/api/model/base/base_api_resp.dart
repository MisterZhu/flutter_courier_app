import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'base_api_parse_exception.dart';

class SsoResp<T> {
  late String status;
  String? message;
  T? data;

  factory SsoResp(jsonStr, Function buildFunc) => jsonStr is String
      ? SsoResp.fromJson(json.decode(jsonStr), buildFunc)
      : SsoResp.fromJson(jsonStr, buildFunc);

  SsoResp.fromJson(Map<String, dynamic> json, Function buildFunc) {
    status = json["status"]?.toString() ?? '';
    message = json["message"];
    final result = json["data"] ?? json['result'] ?? json;
    if (result != null) {
      try {
        data = buildFunc(result);
      } catch (error) {
        if (kDebugMode) debugPrint('BaseApiResp: $error');
        throw BaseApiParseException(message: error.toString());
      }
    }
  }
}

class ApiResp<T> {
  late String code;
  String? message;
  T? data;

  factory ApiResp(jsonStr, Function buildFunc) => jsonStr is String
      ? ApiResp.fromJson(json.decode(jsonStr), buildFunc)
      : ApiResp.fromJson(jsonStr, buildFunc);

  ApiResp.fromJson(Map<String, dynamic> json, Function buildFunc) {
    code = json["code"]?.toString() ?? '';
    message = json["message"];
    final result = json["data"] ?? json['result'] ?? json;
    if (result != null) {
      try {
        data = buildFunc(result);
      } catch (error) {
        if (kDebugMode) debugPrint('BaseApiResp: $error');
        throw BaseApiParseException(message: error.toString());
      }
    }
  }
}

class AdminResp<T> {
  late String code;
  String? message;
  T? data;

  factory AdminResp(jsonStr, Function buildFunc) => jsonStr is String
      ? AdminResp.fromJson(json.decode(jsonStr), buildFunc)
      : AdminResp.fromJson(jsonStr, buildFunc);

  AdminResp.fromJson(Map<String, dynamic> json, Function buildFunc) {
    code = json["code"]?.toString() ?? '';
    message = json["message"];
    final result = json["data"] ?? json['result'] ?? json;
    if (result != null) {
      try {
        data = buildFunc(result);
      } catch (error) {
        if (kDebugMode) debugPrint('BaseApiResp: $error');
        throw BaseApiParseException(message: error.toString());
      }
    }
  }
}

class UploadFileResp<T> {
  late String code;
  String? message;
  T? data;

  factory UploadFileResp(jsonStr, Function buildFunc) => jsonStr is String
      ? UploadFileResp.fromJson(json.decode(jsonStr), buildFunc)
      : UploadFileResp.fromJson(jsonStr, buildFunc);

  UploadFileResp.fromJson(Map<String, dynamic> json, Function buildFunc) {
    code = json["code"]?.toString() ?? '';
    message = json["message"];
    final result = json["data"] ?? json['result'] ?? json;
    if (result != null) {
      try {
        data = buildFunc(result);
      } catch (error) {
        if (kDebugMode) debugPrint('BaseApiResp: $error');
        throw BaseApiParseException(message: error.toString());
      }
    }
  }
}
