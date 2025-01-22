import 'package:courier_app/api/base_api.dart';

class DispatchApi extends BaseApi {
  // 登录
  Future<dynamic> getReturnReason() async {
    Map<String, dynamic> parameters = {
      'type': 2,
    };
    return fetchDataFromPost(
      path: '/android/setting/msg/4',
      json: parameters,
      buildFunc: (e) => e,
    );
  }
}
