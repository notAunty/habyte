import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/tasks/task_list.dart';
import 'package:flutter/material.dart';
import 'package:habyte/views/pages/tasks/_viewTask.dart';

class TasksPage extends StatelessWidget {
  TasksPage({ Key? key }) : super(key: key);

  final Notifiers _notifiers = Notifiers.getInstance();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: _notifiers.getTasksNotifier(),
      builder: (context, tasks, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tasks List',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewTask(taskList: tasks),
                        ),
                      );
                    },
                    icon: const Icon(Icons.calendar_today),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 5,
                      offset: const Offset(0, 3),
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.07),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: TOP_PADDING * 2.5),
                  child: TaskList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
