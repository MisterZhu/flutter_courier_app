import 'package:courier_app/api/base_api.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';

class EncryptData extends BaseApi {
  static Future<String> encryption(String content) async {
    /// 获取公钥
    final publicKeyString =
        await rootBundle.loadString('assets/files/rsa_public_key.pem');

    dynamic key = RSAKeyParser().parse(publicKeyString);

    final encrypter = Encrypter(RSA(publicKey: key));

    return encrypter.encrypt(content).base64;
  }
}
