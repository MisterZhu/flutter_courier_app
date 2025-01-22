import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../managers/cache_manager.dart';

class Environments {
  Environments._();

  // api
  static String get apiDomain => (dotenv.env['API_DOMAIN'] ?? '');
  static bool get apiSSL => dotenv.env['API_SSL']?.toLowerCase() == 'true';
  static String get apiBaseUrl => '${apiSSL ? 'https' : 'http'}://$apiDomain';

  // sso
  static String get ssoDomain => (dotenv.env['SSO_DOMAIN'] ?? '');
  static bool get ssoSSL => dotenv.env['SSO_SSL']?.toLowerCase() == 'true';
  static String get ssoBaseUrl => '${ssoSSL ? 'https' : 'http'}://$ssoDomain';

  // admin
  static String get adminDomain => (dotenv.env['ADMIN_DOMAIN'] ?? '');
  static bool get adminSSL => dotenv.env['ADMIN_SSL']?.toLowerCase() == 'true';
  static String get adminBaseUrl =>
      '${adminSSL ? 'https' : 'http'}://$adminDomain';

  // upload file
  static String get uploadFileDomain =>
      (dotenv.env['UPLOAD_FILE_DOMAIN'] ?? '');
  static bool get uploadFileSSL =>
      dotenv.env['UPLOAD_FILE_SSL']?.toLowerCase() == 'true';
  static String get uploadFileBaseUrl =>
      '${uploadFileSSL ? 'https' : 'http'}://$uploadFileDomain';

  // 是否允许查看错误
  static bool get debugMode =>
      dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';

  // 是否允许使用debug入口
  static bool get debugEntryValid =>
      dotenv.env['DEBUG_ENTRY_VALID']?.toLowerCase() == 'true';

  static Future<void> init() async {
    // 设置当前环境文件名称
    String envName = '.env';
    // alpha版本切换环境会将环境文件名称存储, 此值存在说明非正式版本, 正式版本无此值
    String? debugEnvValue =
        await CacheManager.instance.getEncrypt('DEBUG_ENV_VALUE');
    if (debugEnvValue?.isNotEmpty == true) {
      // alpha版本将环境名称替换为缓存的文件名
      envName = debugEnvValue ?? '.env';
    }
    debugPrint('debugEnvValue: $debugEnvValue');
    debugPrint('envName: $envName');
    // 初始化读取环境文件
    await dotenv.load(fileName: envName);
  }
}
