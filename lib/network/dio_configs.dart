import 'package:courier_app/res/environments.dart';

abstract class DioConfigs {
  static String get apiBaseUrl => Environments.apiBaseUrl;
  static String get ssoBaseUrl => Environments.ssoBaseUrl;
  static String get adminBaseUrl => Environments.adminBaseUrl;
  static String get uploadFileBaseUrl => Environments.uploadFileBaseUrl;

  static const connectTimeout = Duration(seconds: 60);
  static const sendTimeout = Duration(seconds: 60);
  static const receiveTimeout = Duration(seconds: 60);
}
