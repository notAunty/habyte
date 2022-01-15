import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/pages/tasks/task_item.dart';
import 'package:table_calendar/table_calendar.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({required this.taskList, Key? key}) : super(key: key);

  final List<Map<String, dynamic>> taskList;

  @override
  _ViewTaskState createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime firstDay = DateTime.now().subtract(const Duration(days: 3650));
  DateTime lastDay = DateTime.now().add(const Duration(days: 3650));
  DateTime? _selectedDay;
  List<Map<String, dynamic>> todayTaskList = [];

  @override
  Widget build(BuildContext context) {
    todayTaskList = widget.taskList
        .where((task) =>
            task['startDate'].compareTo(_focusedDay) == -1 &&
            (task['endDate'] == null
                ? true
                : task['endDate']!.compareTo(
                        _focusedDay.subtract(const Duration(days: 1))) >=
                    0))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: firstDay,
            lastDay: lastDay,
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: todayTaskList
                            .map((task) => TaskItem(
                                  task: task,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
