import 'package:flutter/material.dart';
import 'package:habyte/models/reminderEntry.dart';
import 'package:habyte/models/task.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:habyte/viewmodels/reminderEntry.dart';
import 'package:habyte/viewmodels/task.dart';
import 'package:habyte/views/classes/global_scaffold.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/calendar.dart';
import 'package:habyte/views/widgets/text_fields.dart';
import 'package:provider/provider.dart';

class TaskEdit extends StatelessWidget {
  TaskEdit({Key? key, this.taskId}) : super(key: key);

  final TaskVM _taskVM = TaskVM.getInstance();
  final ReminderEntryVM _reminderEntryVM = ReminderEntryVM.getInstance();

  final String? taskId;

  late Task _task;
  late ReminderEntry _reminderEntry;

  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _nameController;
  late TextEditingController _pointsController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _reminderTodController;

  late DateTime? _startDate;
  late DateTime? _endDate;
  late bool _reminderBool;
  late TimeOfDay? _reminderTod;

  Map<String, dynamic> getTaskDetailsFromControllers() {
    Map<String, dynamic> toReturn = {
      TASK_NAME: _nameController.text,
      TASK_POINTS: int.parse(_pointsController.text),
      TASK_START_DATE: _startDate,
    };
    if (_endDate != null) toReturn[TASK_END_DATE] = _endDate;

    return toReturn;
  }

  Map<String, dynamic> getReminderEntryDetailsFromControllers(String taskId) =>
      {
        REMINDER_ENTRY_TASK_ID: taskId,
        REMINDER_ENTRY_TIME: _reminderTod,
        REMINDER_ENTRY_STATUS: _reminderBool,
      };

  @override
  Widget build(BuildContext context) {
    bool isValid() => _formKey.currentState!.validate();

    if (taskId != null) {
      _task = _taskVM.retrieveTaskById(taskId!);
      _nameController = TextEditingController(text: _task.name);
      _pointsController = TextEditingController(text: _task.points.toString());
      _startDateController = TextEditingController(
          text: dateFormatterWithYYYYMMDD(_task.startDate));
      _endDateController =
          TextEditingController(text: dateFormatterWithYYYYMMDD(_task.endDate));

      _startDate = _task.startDate;
      _endDate = _task.endDate;

      _reminderEntry = _reminderEntryVM.retrieveReminderEntryByTaskId(taskId!);
      if (_reminderEntry.id != NULL_STRING_PLACEHOLDER) {
        _reminderTodController = TextEditingController(
          text: timeOfDayFormatter(_reminderEntry.reminderTime),
        );

        _reminderBool = _reminderEntry.status;
        _reminderTod = _reminderEntry.reminderTime;
      } else {
        _reminderTodController = TextEditingController();
        _reminderBool = false;
        _reminderTod = null;
      }
    } else {
      _nameController = TextEditingController();
      _pointsController = TextEditingController();
      _startDateController = TextEditingController();
      _endDateController = TextEditingController();
      _reminderTodController = TextEditingController();

      _reminderBool = false;
      _endDate = null;
      _reminderTod = null;
    }

    return AlertDialog(
      title: Text(taskId != null ? 'Edit Task' : 'New Task'),
      insetPadding: const EdgeInsets.all(SIDE_PADDING / 3),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => isValid()
              ? taskId != null
                  ? {
                      if (_reminderEntry.id != NULL_STRING_PLACEHOLDER &&
                          _reminderTod == null)
                        {
                          context.read<GlobalScaffold>().showDefaultSnackbar(
                              message:
                                  "Cannot set NULL value to existing reminder"),
                        }
                      else
                        _task = _taskVM.updateTask(
                          taskId!,
                          getTaskDetailsFromControllers(),
                        ),
                      if (_reminderTod != null)
                        {
                          if (_reminderEntry.id != NULL_STRING_PLACEHOLDER)
                            {
                              _reminderEntryVM.updateReminderEntry(
                                _reminderEntry.id,
                                getReminderEntryDetailsFromControllers(
                                  _task.id,
                                ),
                              ),
                            }
                          else
                            _reminderEntryVM.createReminderEntry(
                              getReminderEntryDetailsFromControllers(
                                _task.id,
                              ),
                            ),
                        },
                      Navigator.of(context).pop(),
                    }
                  : {
                      _task =
                          _taskVM.createTask(getTaskDetailsFromControllers()),
                      if (_reminderTod != null)
                        _reminderEntryVM.createReminderEntry(
                          getReminderEntryDetailsFromControllers(_task.id),
                        ),
                      Navigator.of(context).pop(),
                    }
              : {},
          child: const Text('Done'),
        )
      ],
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFieldLabel(
                label: 'Task Name',
                child: CustomTextField(
                  maxWords: -1,
                  isRequired: true,
                  controller: _nameController,
                ),
              ),
              const SizedBox(height: 12),
              CustomTextFieldLabel(
                label: 'Points (1-5)',
                child: CustomTextField(
                  isRequired: true,
                  controller: _pointsController,
                  isInt: true,
                  maxInt: 5,
                  minInt: 1,
                ),
              ),
              const SizedBox(height: 12),
              CustomTextFieldLabel(
                label: 'Start Date',
                child: CustomTextField(
                  maxWords: -1,
                  isRequired: true,
                  readOnly: true,
                  controller: _startDateController,
                  onTap: () async {
                    Map<String, dynamic> startDateMap =
                        await showCalendar(context);
                    _startDate = startDateMap['date'];
                    _startDateController.text = startDateMap['dateInputText'];
                  },
                ),
              ),
              const SizedBox(height: 12),
              CustomTextFieldLabel(
                label: 'End Date (Optional)',
                child: CustomTextField(
                  maxWords: -1,
                  controller: _endDateController,
                  readOnly: true,
                  onTap: () async {
                    Map<String, dynamic> endDateMap = await showCalendar(
                      context,
                      startDate: _startDate,
                    );
                    _endDate = endDateMap['date'];
                    _endDateController.text = endDateMap['dateInputText'];
                  },
                ),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Reminder',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Switch(
                            onChanged: (value) => setState(
                              () => _reminderBool = !_reminderBool,
                            ),
                            value: _reminderBool,
                          ),
                        ],
                      ),
                      Container(
                        child: _reminderBool
                            ? CustomTextField(
                                maxWords: -1,
                                readOnly: true,
                                controller: _reminderTodController,
                                onTap: () async {
                                  Map<String, dynamic> reminderTodMap =
                                      await showTimeInput(context);
                                  _reminderTod = reminderTodMap['timeOfDay'];
                                  _reminderTodController.text =
                                      reminderTodMap['timeOfDayInputText'];
                                },
                              )
                            : const SizedBox(height: 8),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
