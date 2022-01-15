import 'package:flutter/material.dart';
import 'package:habyte/views/pages/tasks/task_edit.dart';

void onAddTasksPressed(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => TaskEdit(),
  );
}
