import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/models/task.dart';
import 'package:habyte/views/widgets/text_fields.dart';
import 'package:intl/intl.dart';
import '../../widgets/taskItem.dart';
import '../../../viewmodels/task.dart';
import 'package:habyte/views/constant/constants.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final formKey = GlobalKey<FormState>();
  final TaskVM _taskVM = TaskVM.getInstance();
  List<Map<String, dynamic>> taskList = [];
  bool edit = false;
  Map<String, dynamic> editItem = {};
  DateTime? startDate = null;
  DateTime? endDate = null;

  TextEditingController startDateInput = TextEditingController();
  TextEditingController endDateInput = TextEditingController();
  TextEditingController nameInput = TextEditingController();
  TextEditingController pointInput = TextEditingController();

  @override
  void initState() {
    startDateInput.text = "";
    endDateInput.text = "";
    super.initState();
  }

  void addTask() {
    _taskVM.createTask({
      TASK_NAME: nameInput.text,
      TASK_POINTS: int.parse(pointInput.text),
      TASK_START_DATE: startDate,
      TASK_END_DATE: endDate,
    });

    setState(() {
      nameInput.text = '';
      pointInput.text = '';
      startDateInput.text = "";
      endDateInput.text = "";
      startDate = null;
      endDate = null;
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

    //TODO
    /* _taskVM.updateTask(editItem['id'], {
      TASK_NAME: nameInput.text,
      TASK_POINTS: int.parse(pointInput.text),
      TASK_START_DATE: startDate,
      TASK_END_DATE: endDate,
    });*/

    setState(() {
      nameInput.text = '';
      pointInput.text = '';
      startDateInput.text = "";
      endDateInput.text = "";
      startDate = null;
      endDate = null;
      taskList = _taskVM.retrieveAllTasksInListOfMap();
    });
    Navigator.of(context).pop();
  }

  void onClickEdit(Map<String, dynamic> task) {
    setState(() {
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

  Future showCalendar(bool isStartDate) async {
    DateTime dateRange = DateTime.now();

    await showDatePicker(
            context: context,
            initialDate: startDate ?? DateTime.now(),
            firstDate: dateRange,
            lastDate: dateRange.add(Duration(days: 3650)))
        .then((date) {
      if (date != null) {
        if (isStartDate) {
          setState(() {
            this.startDate = date;
            startDateInput.text = DateFormat('yyyy-MM-dd').format(startDate!);
          });
        } else {
          setState(() {
            this.endDate = date;
            endDateInput.text = DateFormat('yyyy-MM-dd').format(endDate!);
          });
        }
      }
    });
  }

  Future toogleDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
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
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                CustomTextFieldLabel(
                  label: 'Start Date',
                  child: CustomTextField(
                      maxWords: -1,
                      isRequired: true,
                      controller: startDateInput,
                      readOnly: true,
                      onTap: () => showCalendar(true)),
                ),
                SizedBox(height: 20),
                CustomTextFieldLabel(
                  label: 'End Date',
                  child: CustomTextField(
                      maxWords: -1,
                      controller: endDateInput,
                      readOnly: true,
                      onTap: () => showCalendar(false)),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(onPressed: onClickDone, child: Text('Done'))
          ]),
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
                            Navigator.pushNamed(context, '/viewTask',
                                arguments: taskList);
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
