import 'package:courier_app/api/api_factory.dart';
import 'package:riverpod/riverpod.dart';

import '../../../api/model/user/courier.dart';

final courierProvider = FutureProvider.autoDispose<CourierInfo>((ref) async {
  CourierInfo courierInfo =
      await ApiFactory.instance.courierApi.getCourierInfo();
  return courierInfo;
});

// class CourierNotifier extends Notifier<CourierInfo> {
//   @override
//   CourierInfo build() {
//     return CourierInfo(
//         email: '',
//         name: '',
//         image: '',
//         invCode: '',
//         invUrl: '',
//         billqty: null,
//         billdqty: null,
//         billpqty: null,
//         billcost: '',
//         billdcost: '',
//         billpcost: '');
//   }
//
//   void update(CourierInfo value) {
//     state = CourierInfo.fromJson(value.toJson());
//   }
// }
//
// final courierProvider = NotifierProvider<CourierNotifier, CourierInfo>(() {
//   return CourierNotifier();
// });
