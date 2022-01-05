import 'package:flutter/material.dart';
import 'package:habyte/models/reminderEntry.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:habyte/viewmodels/reminderEntry.dart';
import 'package:habyte/views/constant/constants.dart';

class ProfileReminders extends StatelessWidget {
  ProfileReminders({Key? key}) : super(key: key);

  final ReminderEntryVM _reminderVM = ReminderEntryVM.getInstance();

  @override
  Widget build(BuildContext context) {
    final reminders = _reminderVM.retrieveAllReminderEntries();

    final mockReminders = [
      ReminderEntry.fromJson(
        {
          REMINDER_ENTRY_TASK_ID: "Help mum buy groceries",
          REMINDER_ENTRY_STATUS: true,
          REMINDER_ENTRY_TIME: const TimeOfDay(hour: 8, minute: 59)
        },
      ),
      ReminderEntry.fromJson(
        {
          REMINDER_ENTRY_TASK_ID: "Sleep early",
          REMINDER_ENTRY_STATUS: true,
          REMINDER_ENTRY_TIME: const TimeOfDay(hour: 15, minute: 59)
        },
      ),
      ReminderEntry.fromJson(
        {
          REMINDER_ENTRY_TASK_ID: "Sleep until later than 12pm",
          REMINDER_ENTRY_STATUS: true,
          REMINDER_ENTRY_TIME: const TimeOfDay(hour: 15, minute: 59)
        },
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Reminders'.toUpperCase(),
            style: Theme.of(context).textTheme.overline),
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: mockReminders.length,
          itemBuilder: (context, index) => ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(mockReminders[index]
                .taskId), // TODO: wp - change to task name instead
            subtitle: Opacity(
              opacity: 0.7,
              child: Text(
                timeOfDayFormatter(mockReminders[index].reminderTime),
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            trailing: Switch(
              value: true, // TODO: wp - link
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (newValue) {
                // TODO: wp - link when toggle
              },
            ),
          ),
        ),
      ],
    );
  }
}
