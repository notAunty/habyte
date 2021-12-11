import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/models/task.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../widgets/taskItem.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({Key? key}) : super(key: key);

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Task> taskList = [];
  List<Task> todayTaskList = [];

  @override
  Widget build(BuildContext context) {
    taskList = ModalRoute.of(context)!.settings.arguments as List<Task>;
    todayTaskList = taskList
        .where((task) =>
            task.startDate.compareTo(_focusedDay) == -1 && 
            (task.endDate==null ? true : task.endDate!.compareTo(_focusedDay.subtract(Duration(days: 1))) >=0))
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: Text('Task List'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
            ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: todayTaskList
                                  .map((task) => TaskItem(
                                        task: task,
                                      ))
                                  .toList()),
                        ],
                      ),
                    )),
              ),
            )
          ],
        ));
  }
}
