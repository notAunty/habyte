import 'package:flutter/material.dart';
import 'package:habyte/models/task.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/viewmodels/reminderEntry.dart';
import 'package:habyte/viewmodels/task.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/constant/sizes.dart';

class ProfileReminders extends StatelessWidget {
  ProfileReminders({Key? key}) : super(key: key);

  final TaskVM _taskVM = TaskVM.getInstance();
  final ReminderEntryVM _reminderEntryVM = ReminderEntryVM.getInstance();
  final Notifiers _notifiers = Notifiers.getInstance();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Reminders'.toUpperCase(),
            style: Theme.of(context).textTheme.overline),
        ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: _notifiers.getReminderEntriesNotifier(),
          builder: (context, reminderEntriesList, child) {
            return reminderEntriesList.isNotEmpty
                ? ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: reminderEntriesList.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> currentReminderEntryInMap =
                          reminderEntriesList[
                              reminderEntriesList.length - 1 - index];
                      Task currentTask = _taskVM.retrieveTaskById(
                        currentReminderEntryInMap[REMINDER_ENTRY_TASK_ID],
                      );

                      String taskName = currentTask.name;
                      TimeOfDay reminderTime =
                          currentReminderEntryInMap[REMINDER_ENTRY_TIME];
                      String reminderTimeInString =
                          timeOfDayFormatter(reminderTime);
                      if (currentTask.startDate.isAfter(DateTime.now())) {
                        reminderTimeInString +=
                            " (Start on ${dateFormatterWithYYYYMMDD(currentTask.startDate)})";
                      }
                      bool reminderBool =
                          currentReminderEntryInMap[REMINDER_ENTRY_STATUS];

                      if (currentReminderEntryInMap[
                              REMINDER_ENTRY_TEMP_OFF_DATE] !=
                          null) {
                        if (isToday(currentReminderEntryInMap[
                            REMINDER_ENTRY_TEMP_OFF_DATE])) {
                          reminderBool = false;
                        }
                      }

                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          taskName,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        subtitle: Opacity(
                          opacity: 0.7,
                          child: Text(
                            reminderTimeInString,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                        trailing: Switch(
                          value: reminderBool,
                          activeColor: Theme.of(context).colorScheme.primary,
                          onChanged: (_) {
                            _reminderEntryVM.updateReminderEntry(
                              currentReminderEntryInMap[REMINDER_ENTRY_ID],
                              {
                                REMINDER_ENTRY_TEMP_OFF_DATE:
                                    reminderBool ? DateTime.now() : null,
                              },
                            );
                          },
                        ),
                      );
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: TOP_PADDING),
                    child: Text("No reminder available yet"),
                  );
          },
        ),
      ],
    );
  }
}
