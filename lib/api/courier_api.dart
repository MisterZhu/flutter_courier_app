import 'package:courier_app/api/base_api.dart';

import 'model/user/courier.dart';

class CourierApi extends BaseApi {
  // 获取快递员信息
  Future<CourierInfo> getCourierInfo() {
    return fetchDataFromGet(
      path: '/android/mycenter/info/1',
      buildFunc: (e) => CourierInfo.fromJson(e),
    );
  }
}
