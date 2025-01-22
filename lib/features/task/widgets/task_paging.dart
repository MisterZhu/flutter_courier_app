import 'package:courier_app/api/model/task/paged_task_list.dart';
import 'package:courier_app/features/task/utils/task_utils.dart';
import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_paging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/task_api.dart';
import '../../../res.dart';
import '../../../res/constants.dart';
import '../../../widgets/app/app_empty.dart';
import '../../../widgets/app/app_error.dart';
import '../../../widgets/app/app_loading.dart';
import '../../../widgets/refresh/error_handle_paging_state.dart';

class TaskPaging extends EasyPaging {
  final TaskType type;
  final WidgetRef ref;

  const TaskPaging({
    super.key,
    required this.type,
    required this.ref,
    super.controller,
    super.itemBuilder,
    super.refreshOnStart = true,
    super.canLoadAfterNoMore = false,
  });

  @override
  ErrorHandlePagingState<List<dynamic>, dynamic> createState() =>
      _TaskPagingState();
}

class _TaskPagingState extends ErrorHandlePagingState<List<dynamic>, dynamic> {
  bool isInit = true;

  @override
  int get count => data?.length ?? 0;

  @override
  dynamic getItem(int index) => data![index];

  @override
  int? page;

  @override
  int? total;

  @override
  int? totalPage;

  CancelToken? _loadToken;
  CancelToken? _refreshToken;

  @override
  Widget buildSliver() {
    return super.buildSliver();
  }

  @override
  Widget? buildRefreshOnStartWidget() {
    return const AppLoading();
  }

  @override
  Widget? buildEmptyWidget() {
    return const AppEmpty(
      icon: Res.order_unchecked,
      text: 'No task found',
    );
  }

  @override
  void dispose() {
    _refreshToken?.cancel();
    _loadToken?.cancel();
    super.dispose();
  }

  @override
  Future<void> onRefresh() async {
    _refreshToken = CancelToken();

    final taskWidget = widget as TaskPaging;

    try {
      final futureProvider = TaskUtils.getProviderByType(taskWidget.type);

      PagedTaskList<dynamic> resp;
      if (isInit) {
        isInit = false;
        resp = await taskWidget.ref.read(futureProvider.future);
      } else {
        resp = await taskWidget.ref.refresh(futureProvider.future);
      }

      if (resp.tasks.isEmpty) {
        setState(() {
          data = [];
          page = 0;
          total = 0;
        });
      } else {
        setState(() {
          data = resp.tasks;
          page = Constants.startPageIndex;
          total = null;
        });
      }
    } catch (error, stackTrace) {
      handleError(
        errorWidget: AppError(
          error: error,
          stackTrace: stackTrace,
          retry: () {
            taskWidget.ref
                .read(
                  TaskUtils.getTimestampProviderByType(taskWidget.type)
                      .notifier,
                )
                .state++;
          },
        ),
      );
    }
  }

  @override
  Future<void> onLoad() async {
    _loadToken = CancelToken();
  }
}
