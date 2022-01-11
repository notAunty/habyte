import 'dart:math';
import 'package:habyte/models/reminderEntry.dart';
import 'package:habyte/models/task.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:habyte/viewmodels/reminderEntry.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/task.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/pages/tasks/_viewTask.dart';
import 'package:habyte/views/widgets/task_item.dart';
import 'package:habyte/views/widgets/text_fields.dart';
import 'package:habyte/views/constant/constants.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final formKey = GlobalKey<FormState>();
  final TaskVM _taskVM = TaskVM.getInstance();
  final ReminderEntryVM _reminderEntryVM = ReminderEntryVM.getInstance();

  List<Map<String, dynamic>> taskList = [];
  Map<String, Map<String, dynamic>> reminderByTaskId = {};
  ReminderEntry? editReminder;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? reminder;
  bool isReminderOn = false;

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController reminderInput = TextEditingController();
  TextEditingController nameInput = TextEditingController();
  TextEditingController pointInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskList = List.from(_taskVM.retrieveAllTasksInListOfMap().reversed);
  }

  Future addTask() async {
    setState(() async {
      Task newTask = _taskVM.createTask({
        TASK_NAME: nameInput.text,
        TASK_POINTS: int.parse(pointInput.text),
        TASK_START_DATE: startDate,
        TASK_END_DATE: endDate,
      });
      taskList.insert(
        0,
        newTask.toMap(),
      );
      if (isReminderOn == true) await addNotification(newTask.id);
    });

    Navigator.of(context).pop();
  }

  Future deleteTask(Map<String, dynamic> taskToBeDeleted, cardSetState) async {
    _taskVM.deleteTask(taskToBeDeleted[TASK_ID]);
    cardSetState(() {
      setState(() {
        taskList = List.from(_taskVM.retrieveAllTasksInListOfMap().reversed);
      });
    });
  }

  Future editTask(String taskId) async {
    //test after notification done
    /*  if (editReminder!.id == null && isReminderOn == true) {
      addNotification();
    } else if (editReminder!.id != null && isReminderOn == false) {
      deleteNotification();
    } else if (editReminder!.id != null &&
        editReminder!.reminderTime != reminder) {
      updateNotification();
    }*/

    setState(() {
      int updatedTaskIndex =
          taskList.indexWhere((task) => task[TASK_ID] == taskId);
      taskList[updatedTaskIndex] = _taskVM.updateTask(taskId, {
        TASK_NAME: nameInput.text,
        TASK_POINTS: int.parse(pointInput.text),
        TASK_START_DATE: startDate,
        TASK_END_DATE: endDate,
      }).toMap();
      print(taskList);
    });
    Navigator.of(context).pop();
  }

  Future<void> addNotification(String taskId) async {
    ReminderEntry newReminderEntry = await _reminderEntryVM.createReminderEntry(
      {
        REMINDER_ENTRY_TASK_ID: taskId,
        REMINDER_ENTRY_TIME: reminder,
      },
    );
    reminderByTaskId[taskId] = newReminderEntry.toMap();
  }

  void deleteNotification() {
    _reminderEntryVM.deleteReminderEntry(editReminder!.id);
  }

  void updateNotification() {
    _reminderEntryVM.updateReminderEntry(editReminder!.id, {
      REMINDER_ENTRY_TASK_ID: editReminder!.taskId,
      REMINDER_ENTRY_TIME: reminder
    });
  }

  void onClickEdit(Map<String, dynamic> task, cardSetState) {
    cardSetState(() {
      setState(() {
        editReminder =
            _reminderEntryVM.retrieveReminderEntryById(task[TASK_ID]);
      });
      toggleDialog(taskToBeEdited: task);
    });
  }

  void onClickAdd() {
    toggleDialog();
  }

  void onClickDone({String? taskId}) {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      if (taskId != null) {
        editTask(taskId);
      } else {
        addTask();
      }
    }
  }

  Future toggleDialog({Map<String, dynamic>? taskToBeEdited}) async {
    String title = taskToBeEdited != null ? 'Edit Task' : 'New Task';
    if (taskToBeEdited != null) {
      nameInput.text = taskToBeEdited[TASK_NAME];
      pointInput.text = taskToBeEdited[TASK_POINTS].toString();
      startDate = taskToBeEdited[TASK_START_DATE];
      endDate = taskToBeEdited[TASK_END_DATE];
      startDateInput.text =
          DateFormat("yyyy-MM-dd").format(taskToBeEdited[TASK_START_DATE]);
      endDateInput.text = taskToBeEdited[TASK_END_DATE] != null
          ? DateFormat('yyyy-MM-dd').format(taskToBeEdited[TASK_END_DATE]!)
          : '';
      isReminderOn = editReminder!.id == NULL_STRING_PLACEHOLDER ? false : true;
      reminder = editReminder!.id == NULL_STRING_PLACEHOLDER
          ? null
          : editReminder!.reminderTime;
      reminderInput.text = editReminder!.id == NULL_STRING_PLACEHOLDER
          ? ''
          : timeOfDayFormatter(editReminder!.reminderTime);
    } else {
      nameInput.text = '';
      pointInput.text = '';
      startDateInput.text = "";
      endDateInput.text = "";
      reminderInput.text = "";
      reminder = null;
      isReminderOn = false;
      startDate = null;
      endDate = null;
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(title),
            insetPadding: const EdgeInsets.all(SIDE_PADDING / 3),
            backgroundColor: Theme.of(context).colorScheme.surface,
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => taskToBeEdited != null
                    ? onClickDone(taskId: taskToBeEdited[TASK_ID])
                    : onClickDone(),
                child: const Text('Done'),
              )
            ],
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextFieldLabel(
                      label: 'Task Name',
                      child: CustomTextField(
                        maxWords: -1,
                        isRequired: true,
                        controller: nameInput,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFieldLabel(
                      label: 'Points (1-5)',
                      child: CustomTextField(
                        maxWords: -1,
                        isRequired: true,
                        controller: pointInput,
                        isInt: true,
                        maxInt: 5,
                        minInt: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFieldLabel(
                      label: 'Start Date',
                      child: CustomTextField(
                        maxWords: -1,
                        isRequired: true,
                        controller: startDateInput,
                        readOnly: true,
                        onTap: () async {
                          Map<String, dynamic> startDateMap =
                              await showCalendar(context);
                          startDate = startDateMap['startDate'];
                          startDateInput.text =
                              startDateMap['startDateInputText'];
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFieldLabel(
                      label: 'End Date (Optional)',
                      child: CustomTextField(
                        maxWords: -1,
                        controller: endDateInput,
                        readOnly: true,
                        onTap: () async {
                          Map<String, dynamic> endDateMap =
                              await showCalendar(context, startDate: startDate, isStartDate: false);
                          endDate = endDateMap['endDate'];
                          endDateInput.text =
                              endDateMap['endDateInputText'];
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Reminder',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Switch(
                          onChanged: (value) {
                            if (value == true) {
                              setState(() {
                                isReminderOn = value;
                              });
                            } else {
                              setState(() {
                                isReminderOn = value;
                                reminder = null;
                                reminderInput.text = '';
                              });
                            }
                          },
                          value: isReminderOn,
                        ),
                      ],
                    ),
                    Container(
                      child: isReminderOn == true
                          ? CustomTextField(
                              maxWords: -1,
                              controller: reminderInput,
                              readOnly: true,
                              onTap: () => showTimeInput(context),
                            )
                          : const SizedBox(height: 1),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: Random.secure().nextDouble(),
        onPressed: onClickAdd,
        child: const Icon(Icons.add, color: WHITE_01),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
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
                          builder: (context) => ViewTask(taskList: taskList),
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
                      topRight: Radius.circular(60)),
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: TOP_PADDING * 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: taskList
                            .map((task) => TaskItem(
                                  task: task,
                                  onEdit: onClickEdit,
                                  onDelete: deleteTask,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
