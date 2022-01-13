import 'package:flutter/material.dart';
import 'package:habyte/models/reminderEntry.dart';
import 'package:habyte/models/task.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/viewmodels/reminderEntry.dart';
import 'package:habyte/viewmodels/task.dart';
import 'package:habyte/views/constant/constants.dart';

class ProfileReminders extends StatelessWidget {
  ProfileReminders({Key? key}) : super(key: key);

  final TaskVM _taskVM = TaskVM.getInstance();
  final ReminderEntryVM _reminderVM = ReminderEntryVM.getInstance();
  final Notifiers _notifiers = Notifiers.getInstance();

  @override
  Widget build(BuildContext context) {
    final reminders = _reminderVM.retrieveAllReminderEntries();

    final mockReminders = [
      ReminderEntry.createFromJson(
        {
          REMINDER_ENTRY_TASK_ID: "Help mum buy groceries",
          REMINDER_ENTRY_STATUS: true,
          REMINDER_ENTRY_TIME: const TimeOfDay(hour: 8, minute: 59)
        },
      ),
      ReminderEntry.createFromJson(
        {
          REMINDER_ENTRY_TASK_ID: "Sleep early",
          REMINDER_ENTRY_STATUS: true,
          REMINDER_ENTRY_TIME: const TimeOfDay(hour: 15, minute: 59)
        },
      ),
      ReminderEntry.createFromJson(
        {
          REMINDER_ENTRY_TASK_ID: "Sleep until later than 12pm",
          REMINDER_ENTRY_STATUS: true,
          REMINDER_ENTRY_TIME: const TimeOfDay(hour: 15, minute: 59)
        },
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Reminders'.toUpperCase(),
            style: Theme.of(context).textTheme.overline),
        ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: _notifiers.getReminderEntriesNotifier(),
          builder: (context, reminderEntriesList, child) {
            return Flexible(
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: reminderEntriesList.length,
                  itemBuilder: (context, index) {
                    Task currentTask = _taskVM.retrieveTaskById(
                      reminderEntriesList[reminderEntriesList.length -
                          1 -
                          index][REMINDER_ENTRY_TASK_ID],
                    );
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        currentTask.name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      subtitle: Opacity(
                        opacity: 0.7,
                        child: Text(
                          timeOfDayFormatter(
                              reminderEntriesList[index][REMINDER_ENTRY_TIME]),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      trailing: Switch(
                        value: reminderEntriesList[reminderEntriesList.length -
                            1 -
                            index][REMINDER_ENTRY_STATUS],
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (newValue) {
                          // TODO: wp - link when toggle
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
