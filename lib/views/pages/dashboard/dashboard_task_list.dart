import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/viewmodels/taskEntry.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/double_value_listenable_builder.dart';

class DashboardTaskList extends StatelessWidget {
  DashboardTaskList({Key? key}) : super(key: key);

  final TaskEntryVM _taskEntryVM = TaskEntryVM.getInstance();
  final Notifiers _notifiers = Notifiers.getInstance();

  @override
  Widget build(BuildContext context) {
    return DoubleValueListenableBuilder<List<Map<String, dynamic>>,
        Map<String, bool>>(
      firstValueListenable: _notifiers.getTasksNotifier(),
      secondValueListenable: _notifiers.getTasksInIdCheckedNotifier(),
      builder: (context, taskList, tasksInIdChecked) {
        return Expanded(
          child: SingleChildScrollView(
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(
                  SIDE_PADDING - 4, 8, SIDE_PADDING, 0),
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                // Reverse it, view from the latest to the oldest
                String currentId = taskList[index][TASK_ID];
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: tasksInIdChecked[currentId]! ? 0.5 : 1.0,
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0,
                    leading: SizedBox(
                      width: 32,
                      child: tasksInIdChecked[currentId]!
                          ? Image.asset('assets/check/checked.png')
                          : Image.asset('assets/check/unchecked.png'),
                    ),
                    title: Text(
                      taskList[index][TASK_NAME],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          decoration: tasksInIdChecked[currentId]!
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    onTap: () {
                      !tasksInIdChecked[currentId]!
                          ? {
                              _taskEntryVM.createTaskEntry({
                                TASK_ENTRY_TASK_ID: currentId,
                                TASK_ENTRY_COMPLETED_DATE: DateTime.now()
                              })
                            }
                          : {_taskEntryVM.deleteTaskEntryByTaskId(currentId)};
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
