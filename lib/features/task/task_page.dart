import 'package:courier_app/ext/async_value_ext.dart';
import 'package:courier_app/features/task/providers/task_providers.dart';
import 'package:courier_app/features/task/task_child_page.dart';
import 'package:courier_app/features/task/task_assigning_page.dart';
import 'package:courier_app/features/task/utils/task_utils.dart';
import 'package:courier_app/features/task_map/task_map_page.dart';
import 'package:courier_app/utils/nav_utils.dart';
import 'package:courier_app/widgets/scaffold/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/model/task/paged_task_list.dart';
import '../../api/model/task/task.dart';
import '../../api/task_api.dart';
import '../../widgets/tab_bar_view_control/tab_bar_view_control.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      canBack: false,
      appBarTitle: 'Task',
      actions: [
        TextButton(
          onPressed: () {
            NavUtils.to(const TaskMapPage());
          },
          child: Text('Task Map'),
        ),
      ],
      body: _renderPageContent(),
    );
  }

  Widget _renderPageContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: TabBarViewControl(
        physics: const NeverScrollableScrollPhysics(),
        tabs: [
          _buildTab(TaskType.all, taskAllListProvider),
          _buildTab(TaskType.dispatch, taskDispatchListProvider),
          _buildTab(TaskType.pick_up, taskPickUpListProvider),
          _buildTab(TaskType.assigning, taskAssigningListProvider),
        ],
        height: 40,
        children: const [
          TaskChildPage(type: TaskType.all),
          TaskChildPage(type: TaskType.dispatch),
          TaskChildPage(type: TaskType.pick_up),
          TaskAssigningPage(),
        ],
      ),
    );
  }

  Tab _buildTab(TaskType taskType,
      AutoDisposeFutureProvider<PagedTaskList<Task>> provider) {
    return Tab(
      child: Consumer(
        builder: (context, ref, _) {
          return ref.watch(provider).whenSilent(
                data: (data) => Column(
                  children: [
                    Text(
                      TaskUtils.getTabName(taskType),
                      maxLines: 1,
                    ),
                    Text(
                      data == null
                          ? "(0)"
                          : TaskUtils.getTabText(data.tasks, taskType),
                      maxLines: 1,
                    ),
                  ],
                ),
              );
        },
      ),
    );
  }
}
