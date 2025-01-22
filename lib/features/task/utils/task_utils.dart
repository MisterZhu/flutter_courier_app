import 'dart:ui';

import 'package:courier_app/api/task_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/model/task/paged_task_list.dart';
import '../../../api/model/task/task.dart';
import '../../../res/colours.dart';
import '../providers/task_providers.dart';

abstract class TaskUtils {
  static AutoDisposeStateProvider<int> getTimestampProviderByType(
          TaskType type) =>
      switch (type) {
        TaskType.all => taskAllTimestampProvider,
        TaskType.dispatch => taskDispatchTimestampProvider,
        TaskType.pick_up => taskPickUpTimestampProvider,
        TaskType.assigning => taskAssigningTimestampProvider,
      };

  static AutoDisposeFutureProvider<PagedTaskList<dynamic>> getProviderByType(
          TaskType type) =>
      switch (type) {
        TaskType.all => taskAllListProvider,
        TaskType.dispatch => taskDispatchListProvider,
        TaskType.pick_up => taskPickUpListProvider,
        TaskType.assigning => taskAssigningListProvider,
      };

  //任务类型(1:派件任务，3:取件任务，5:待确认的取件任务，6:待抢单的取件任务)
  static Color getLevelColor(int taskType) => switch (taskType) {
        1 => Colours.taskYellowColor,
        3 => Colours.taskBussiness1,
        _ => Colours.taskBussiness1,
      };

  //客户类型(-3 shein退件,1商业件,5 take a lot，-2表示重货)
  static String getLabelText(int customerType) {
    late String label = '';
    switch (customerType) {
      case 5:
        label = 'Takealot';
        break;

      case 1:
        label = 'Bussiness';
        break;

      case -2:
        label = 'Heavy Freight';
        break;
    }
    return label;
  }

  static bool isShowLabel(int customerType) {
    if (customerType == 5 || customerType == 1 || customerType == 2) {
      return true;
    }
    return false;
  }

  static String getTabName(TaskType type) {
    late String tabName = '';
    switch (type) {
      case TaskType.all:
        tabName = 'All';
        break;

      case TaskType.dispatch:
        tabName = 'Dispatch';
        break;

      case TaskType.pick_up:
        tabName = 'Pick-up';
        break;
      case TaskType.assigning:
        tabName = 'Assigning';
        break;
    }
    return tabName;
  }

  static String getTabText(List<Task> tasks, TaskType type) {
    late String tabText = '';
    switch (type) {
      case TaskType.all:
        int count = getCount(tasks, TaskType.dispatch.value);
        num packages = getPackagesCount(tasks, TaskType.pick_up.value);
        tabText = '(${count + packages})';
        break;

      case TaskType.dispatch:
        int count = getCount(tasks, TaskType.dispatch.value);
        tabText = '($count)';
        break;

      case TaskType.pick_up:
        int count = getCount(tasks, TaskType.pick_up.value);
        num packages = getPackagesCount(tasks, TaskType.pick_up.value);
        tabText = '($count , $packages)';
        break;
      case TaskType.assigning:
        int count = getCount(tasks, TaskType.assigning.value);
        num packages = getPackagesCount(tasks, TaskType.assigning.value);
        tabText = '($count , $packages)';
        break;
    }
    return tabText;
  }

  static int getCount(List<Task> tasks, int type) {
    return filterData(tasks, type).length;
  }

  static num getPackagesCount(List<Task> tasks, int type) {
    List<Task> taskList = filterData(tasks, type);
    num packages = 0;
    for (var task in taskList) {
      if (task.packages != null) {
        packages += task.packages!;
      }
    }
    return packages;
  }

  static List<Task> filterData(List<Task> tasks, int type) {
    return tasks.where((task) => task.tasktype == type).toList();
  }
}
