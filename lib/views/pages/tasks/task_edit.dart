import 'package:flutter/material.dart';
import 'package:habyte/models/reminderEntry.dart';
import 'package:habyte/models/task.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:habyte/viewmodels/reminderEntry.dart';
import 'package:habyte/viewmodels/task.dart';
import 'package:habyte/views/constant/constants.dart';

class TaskEdit extends StatelessWidget {
  TaskEdit({
    Key? key,
    this.taskId,
    required this.isUpdate,
  }) : super(key: key);

  final TaskVM _taskVM = TaskVM.getInstance();
  final ReminderEntryVM _reminderEntryVM = ReminderEntryVM.getInstance();

  late Task _task;
  late ReminderEntry _reminderEntry;

  final bool isUpdate;
  final String? taskId;
  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _nameController;
  late TextEditingController _pointsController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _reminderController;

  late DateTime _startDate;
  late DateTime _endDate;

  Map<String, dynamic> getTaskDetailsFromControllers() => {
        TASK_NAME: _nameController.text,
        TASK_POINTS: int.parse(_pointsController.text),
        TASK_START_DATE: _startDate,
        TASK_END_DATE: _endDate
      };

  @override
  Widget build(BuildContext context) {
    if (taskId != null) {
      _task = _taskVM.retrieveTaskById(taskId!);
      _reminderEntry = _reminderEntryVM.retrieveReminderEntryByTaskId(taskId!);
    }
    
    _nameController =
        TextEditingController(text: (taskId == null) ? "" : _task.name);
    _pointsController = TextEditingController(
        text: (taskId == null) ? "" : _task.points.toString());
    _startDateController = TextEditingController(
        text:
            (taskId == null) ? "" : dateFormatterWithYYYYMMDD(_task.startDate));
    _endDateController = TextEditingController(
        text: (taskId == null || _task.endDate == null)
            ? ""
            : dateFormatterWithYYYYMMDD(_task.endDate!));
    _reminderController = TextEditingController();

    return AlertDialog(
      title: Text(isUpdate ? 'Edit Task' : 'New Task'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => isUpdate
              ? _taskVM.updateTask(taskId!, getTaskDetailsFromControllers())
              : _taskVM.createTask(getTaskDetailsFromControllers()),
          child: const Text('Done'),
        )
      ],
    );
  }
}
