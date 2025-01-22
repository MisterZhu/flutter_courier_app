import 'package:courier_app/ext/auto_dispose_ref_ext.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/api_factory.dart';
import '../../../api/model/task/paged_task_list.dart';
import '../../../api/model/task/task.dart';
import '../../../api/task_api.dart';

final taskListSortProvider = StateProvider.autoDispose<List<Task>?>((ref) {
  return null;
});

//all
final taskAllTimestampProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
final taskAllListProvider =
    FutureProvider.autoDispose<PagedTaskList<Task>>((ref) async {
  final _ = ref.watch(taskAllTimestampProvider);
  return ApiFactory.instance.taskApi.getTaskList(
    cancelToken: ref.getDisposeCancelToken(),
  );
});

//dispatch
final taskDispatchTimestampProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
final taskDispatchListProvider =
    FutureProvider.autoDispose<PagedTaskList<Task>>((ref) async {
  final _ = ref.watch(taskDispatchTimestampProvider);

  final taskList = ApiFactory.instance.taskApi.getTaskList(
    cancelToken: ref.getDisposeCancelToken(),
  );

  final filteredTaskList = taskList.then((value) => PagedTaskList(
      tasks: value.tasks
          .where((task) => task.tasktype == TaskType.dispatch.value)
          .toList(),
      dutystatus: value.dutystatus,
      count: value.count,
      drivertype: value.drivertype));
  return filteredTaskList;
});

//pickup
final taskPickUpTimestampProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
final taskPickUpListProvider =
    FutureProvider.autoDispose<PagedTaskList<Task>>((ref) async {
  final _ = ref.watch(taskPickUpTimestampProvider);

  final taskList = ApiFactory.instance.taskApi.getTaskList(
    cancelToken: ref.getDisposeCancelToken(),
  );

  final filteredTaskList = taskList.then((value) => PagedTaskList(
      tasks: value.tasks
          .where((task) => task.tasktype == TaskType.pick_up.value)
          .toList(),
      dutystatus: value.dutystatus,
      count: value.count,
      drivertype: value.drivertype));
  return filteredTaskList;
});

//assigning
final taskAssigningTimestampProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
final taskAssigningListProvider =
    FutureProvider.autoDispose<PagedTaskList<Task>>((ref) async {
  final _ = ref.watch(taskAssigningTimestampProvider);

  final taskList = ApiFactory.instance.taskApi.getTaskList(
    cancelToken: ref.getDisposeCancelToken(),
  );

  final filteredTaskList = taskList.then((value) => PagedTaskList(
      tasks: value.tasks
          .where((task) => task.tasktype == TaskType.assigning.value)
          .toList(),
      dutystatus: value.dutystatus,
      count: value.count,
      drivertype: value.drivertype));
  return filteredTaskList;
});
