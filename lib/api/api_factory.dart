import 'package:courier_app/api/dispatch_detail.dart';
import 'package:courier_app/api/task_api.dart';
import 'package:courier_app/api/courier_api.dart';
import 'package:courier_app/api/user_api.dart';

class ApiFactory {
  static final ApiFactory _instance = ApiFactory._();

  static ApiFactory get instance => _instance;

  ApiFactory._();

  late final UserApi userApi = UserApi();
  late final CourierApi courierApi = CourierApi();
  late final TaskApi taskApi = TaskApi();
  late final DispatchApi dispatchApi = DispatchApi();
}
