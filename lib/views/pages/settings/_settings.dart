import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/viewmodels/reminderEntry.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ReminderEntryVM _reminderEntryVM = ReminderEntryVM.getInstance();
  bool darkMode = false;
  List<Map<String, dynamic>> reminderList = [
    {
      'REMINDER_ENTRY_TASK_ID': 'R0001',
      'REMINDER_ENTRY_TIME': TimeOfDay(hour: 8, minute: 0),
      'REMINDER_ENTRY_NAME': 'Wake up',
      'REMINDER_STATUS': true,
    },
    {
      'REMINDER_ENTRY_TASK_ID': 'R0002',
      'REMINDER_ENTRY_TIME': TimeOfDay(hour: 18, minute: 0),
      'REMINDER_ENTRY_NAME': 'Workout',
      'REMINDER_STATUS': true,
    },
    {
      'REMINDER_ENTRY_TASK_ID': 'R0001',
      'REMINDER_ENTRY_TIME': TimeOfDay(hour: 22, minute: 0),
      'REMINDER_ENTRY_NAME': 'Sleep',
      'REMINDER_STATUS': true,
    }
  ];
  //dummy data
  @override
  Widget build(BuildContext context) {
    final _reminderEntryList =
        _reminderEntryVM.retrieveAllReminderEntriesInListOfMap();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder'),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: TOP_PADDING, width: double.infinity),
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark Mode',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Switch(
                      onChanged: (value) {
                        setState(() {
                          darkMode = value;
                        });
                      },
                      value: darkMode,
                    ),
                  ],
                ),
              ],
            )),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: Text(
              'Reminder',
              style: TextStyle(color: WHITE_01),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: reminderList.map((reminder)=>
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reminder['REMINDER_ENTRY_NAME']+"  -  "+timeOfDayFormatter(reminder['REMINDER_ENTRY_TIME']),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Switch(
                      onChanged: (value) {},
                      value: reminder['REMINDER_STATUS'],
                    ),
                  ],
                ),
              ).toList(),
            )),
      ]),
    );
  }
}
