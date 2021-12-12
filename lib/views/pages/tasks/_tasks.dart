import 'package:flutter/material.dart';
import 'package:habyte/models/notification.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/pages/tasks/_viewTask.dart';
import 'package:habyte/views/widgets/text_fields.dart';
import 'package:intl/intl.dart';
import '../../widgets/taskItem.dart';
import '../../../viewmodels/task.dart';
import '../../../viewmodels/notification.dart';
import 'package:habyte/views/constant/constants.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final formKey = GlobalKey<FormState>();
  final TaskVM _taskVM = TaskVM.getInstance();
  final NotificationDetailVM _notificationVM =
      NotificationDetailVM.getInstance();
  List<Map<String, dynamic>> taskList = [];
  bool edit = false;
  Map<String, dynamic> editItem = {};
  NotificationDetail? editNotification = null;
  DateTime? startDate = null;
  DateTime? endDate = null;
  TimeOfDay? reminder = null;
  bool isReminderOn = false;

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController reminderInput = TextEditingController();
  TextEditingController nameInput = TextEditingController();
  TextEditingController pointInput = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void initiailInput() {
    setState(() {
      nameInput.text = '';
      pointInput.text = '';
      startDateInput.text = "";
      endDateInput.text = "";
      reminderInput.text = "";
      reminder = null;
      isReminderOn = false;
      startDate = null;
      endDate = null;
    });
  }

  void addTask() {
    _taskVM.createTask({
      TASK_NAME: nameInput.text,
      TASK_POINTS: int.parse(pointInput.text),
      TASK_START_DATE: startDate,
      TASK_END_DATE: endDate,
    });

    //TO DO: add notification
    //addNotification()
    initiailInput();
    setState(() {
      taskList = _taskVM.retrieveAllTasksInListOfMap();
    });

    Navigator.of(context).pop();
  }

  Future deleteTask(task) async {
    _taskVM.deleteTask(task['id']);

    setState(() {
      taskList = _taskVM.retrieveAllTasksInListOfMap();
    });
  }

  Future editTask() async {
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
    initiailInput();
    setState(() {
      taskList = _taskVM.retrieveAllTasksInListOfMap();
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
      editItem = task;
      edit = true;
      nameInput.text = task['name'];
      pointInput.text = task['points'].toString();
      startDate = task['startDate'];
      endDate = task['endDate'];
      startDateInput.text = DateFormat("yyyy-MM-dd").format(task['startDate']);
      endDateInput.text = task['endDate'] != null
          ? DateFormat('yyyy-MM-dd').format(task['endDate']!)
          : '';
    });
    toogleDialog();
  }

  void onClickAdd() {
    setState(() {
      edit = false;
    });
    toogleDialog();
  }

  void onClickDone() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      if (edit == true) {
        editTask();
      } else {
        addTask();
      }
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  Future showTimeInput(BuildContext context) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 0),
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
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
          reminderInput.text = formatTimeOfDay(time);
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
      lastDate: dateRange.add(Duration(days: 3650)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
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

  Future toogleDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: AlertDialog(
                insetPadding: EdgeInsets.all(10),
                title: Text(edit == true ? 'Edit Task' : 'New Task'),
                content: Form(
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
                      SizedBox(height: 10),
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
                      SizedBox(height: 10),
                      CustomTextFieldLabel(
                        label: 'Start Date',
                        child: CustomTextField(
                            maxWords: -1,
                            isRequired: true,
                            controller: startDateInput,
                            readOnly: true,
                            onTap: () => showCalendar(true)),
                      ),
                      SizedBox(height: 10),
                      CustomTextFieldLabel(
                        label: 'End Date (Optional)',
                        child: CustomTextField(
                            maxWords: -1,
                            controller: endDateInput,
                            readOnly: true,
                            onTap: () => showCalendar(false)),
                      ),
                      SizedBox(height: 10),
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
                                onTap: () => showTimeInput(context))
                            : SizedBox(height: 1),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        initiailInput();
                      },
                      child: Text('Cancel')),
                  TextButton(onPressed: onClickDone, child: Text('Done'))
                ]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.all(25),
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
                                    builder: (context) =>
                                        ViewTask(taskList: taskList)));
                          },
                          icon: Icon(Icons.calendar_today))
                    ])),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: WHITE_01, //Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: taskList
                                .map((task) => TaskItem(
                                      task: task,
                                      delete: deleteTask,
                                      edit: onClickEdit,
                                    ))
                                .toList()),
                      ],
                    ),
                  )),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: onClickAdd,
          child: Icon(
            Icons.add,
            color: WHITE_01,
          )),
    );
  }
}
