import 'package:courier_app/api/base_api.dart';
import 'package:dio/dio.dart';

import 'model/task/paged_task_list.dart';
import 'model/task/task.dart';

enum TaskType {
  //任务类型(1:派件任务，3:取件任务，5:待确认的取件任务，6:待抢单的取件任务)
  all(-1),
  dispatch(1),
  pick_up(3),
  assigning(5);

  final int value;

  const TaskType(this.value);
}

class TaskApi extends BaseApi {
  Future<PagedTaskList<Task>> getTaskList({
    CancelToken? cancelToken,
  }) {
    final Map<String, dynamic> param = {
      'type': 1,
    };

    return fetchDataFromGet(
      path: '/android/express/task/2',
      queryParameters: param,
      cancelToken: cancelToken,
      buildFunc: (e) => PagedTaskList.fromJson(
        e,
        modelBuilder: (e) => Task.fromJson(e),
      ),
    );
  }
}
