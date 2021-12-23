import 'package:habyte/models/reminderEntry.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:habyte/viewmodels/reminderEntry.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/task.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/pages/tasks/_viewTask.dart';
import 'package:habyte/views/widgets/task_card.dart';
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
    taskList = _taskVM.retrieveAllTasksInListOfMap();
  }

  void addTask() {
    //TO DO: add notification
    //addNotification()
    setState(() {
      taskList.add(_taskVM.createTask({
        TASK_NAME: nameInput.text,
        TASK_POINTS: int.parse(pointInput.text),
        TASK_START_DATE: startDate,
        TASK_END_DATE: endDate,
      }).toMap());
      print(taskList);
    });

    Navigator.of(context).pop();
  }

  Future deleteTask(Map<String, dynamic> taskToBeDeleted) async {
    _taskVM.deleteTask(taskToBeDeleted[TASK_ID]);

    setState(() {
      taskList = _taskVM.retrieveAllTasksInListOfMap();
    });
  }

  Future editTask(String taskId) async {
    //TODO: edit task
    /* _taskVM.updateTask(editItem['id'], {
      TASK_NAME: nameInput.text,
      TASK_POINTS: int.parse(pointInput.text),
      TASK_START_DATE: startDate,
      TASK_END_DATE: endDate,
    });*/

    /*if(editNotification==null && isReminderOn==true){
        //addNotification()
    }else if(editNotification!=null && isReminderOn==false){
      //deleteNotification()
    }else if(editNotification!=null && editNotification.notificationTime!=reminder){
      //updateNotification()
    }*/
    setState(() {
      int updatedTaskIndex =
          taskList.firstWhere((task) => task[TASK_ID] == taskId)[TASK_ID];
      taskList[updatedTaskIndex] = _taskVM.updateTask(taskId, {
        TASK_NAME: nameInput.text,
        TASK_POINTS: int.parse(pointInput.text),
        TASK_START_DATE: startDate,
        TASK_END_DATE: endDate,
      }).toMap();
    });
    Navigator.of(context).pop();
  }

  void addNotification() {}
  void deleteNotification() {}
  void updateNotification() {}

  void onClickEdit(Map<String, dynamic> task) {
    /* NotificationDetail editNotification =
        _notificationVM.retrieveNotificationDetailByTaskId(task['id']);*/

    setState(() {
      //isReminderOn=editNotification == null ? false : true;
      //reminder= editNotification.notificationTime;
      //reminderInput= formatTimeOfDay(editNotification.notificationTime);
      //editNotification = editNotification;
    });
    toggleDialog(taskToBeEdited: task);
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

  Future showTimeInput(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    ).then((time) {
      if (time != null) {
        setState(() {
          this.reminder = time;
          reminderInput.text = timeOfDayFormatter(time);
        });
        print(reminder!.hour);
      }
    });
  }

  Future showCalendar(bool isStartDate) async {
    DateTime dateRange = isStartDate
        ? DateTime.now()
        : startDate == null
            ? DateTime.now()
            : startDate!;

    await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: dateRange,
      cancelText: 'Clear',
      lastDate: dateRange.add(const Duration(days: 3650)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    ).then((date) {
      if (date != null) {
        if (isStartDate) {
          setState(() {
            this.startDate = date;
            startDateInput.text = DateFormat('yyyy-MM-dd').format(startDate!);
          });
          if (endDate != null && endDate!.compareTo(startDate!) < 0) {
            print('exe');
            setState(() {
              this.endDate = null;
              endDateInput.text = '';
            });
          }
        } else {
          setState(() {
            this.endDate = date;
            endDateInput.text = DateFormat('yyyy-MM-dd').format(endDate!);
          });
        }
      } else {
        if (isStartDate) {
          setState(() {
            this.startDate = null;
            startDateInput.text = '';
          });
        } else {
          setState(() {
            this.endDate = null;
            endDateInput.text = '';
          });
        }
      }
    });
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
            insetPadding: const EdgeInsets.all(10),
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
                        onTap: () => showCalendar(true),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFieldLabel(
                      label: 'End Date (Optional)',
                      child: CustomTextField(
                        maxWords: -1,
                        controller: endDateInput,
                        readOnly: true,
                        onTap: () => showCalendar(false),
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
                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.07),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: taskList
                              .map((task) => TaskCard(
                                    task: task,
                                    delete: deleteTask,
                                    edit: onClickEdit,
                                  ))
                              .toList(),
                        ),
                      ],
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
