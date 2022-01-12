import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/viewmodels/task.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/tasks/task_edit.dart';
import 'package:habyte/views/widgets/task_item.dart';

class TaskList extends StatelessWidget {
  TaskList({Key? key}) : super(key: key);

  final TaskVM _taskVM = TaskVM.getInstance();
  final Notifiers _notifiers = Notifiers.getInstance();

  void editTask(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (context) => TaskEdit(
        taskId: taskId,
      ),
    );
  }

  void deleteTask(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure you want to delete?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _taskVM.deleteTask(taskId);
              Navigator.of(context).pop();
            },
            child: const Text("Yes"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(bottom: TOP_PADDING * 4),
          child: ValueListenableBuilder<List<Map<String, dynamic>>>(
            valueListenable: _notifiers.getTasksNotifier(),
            builder: (context, taskList, child) {
              return ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: taskList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 8.0),
                itemBuilder: (context, index) {
                  return TaskItem(
                    task: taskList[index],
                    onEdit: editTask,
                    onDelete: deleteTask,
                  );
                },
              );
            },
          )
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: taskList
          //       .map((task) => TaskItem(
          //             task: task,
          //             onEdit: onClickEdit,
          //             onDelete: deleteTask,
          //           ))
          //       .toList(),
          // ),
          ),
    );
  }
}
