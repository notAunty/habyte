import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habyte/main.dart';
import 'package:habyte/models/reminderEntry.dart';
import 'package:habyte/models/taskEntry.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:habyte/viewmodels/task.dart';
import 'package:habyte/viewmodels/taskEntry.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

/// **Notification Handler Class**
///
/// Involves:
/// - Notification Handler
/// - CUD (Create, Update, Delete) notification
class NotificationHandler {
  static final NotificationHandler _notificationHandler =
      NotificationHandler._internal();
  NotificationHandler._internal();

  /// Get the `NotificationHandler`
  factory NotificationHandler.getInstance() => _notificationHandler;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future init(List<ReminderEntry> reminderEntries) async {
    _configureLocalTimeZone();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: initializationSettingsAndroid),
      onSelectNotification: (payload) => main(),
    );
    // Testing purpose
    await flutterLocalNotificationsPlugin.cancelAll();
    for (ReminderEntry reminderEntry in reminderEntries) {
      if (reminderEntry.status) {
        TaskEntry? latestTaskEntry = TaskEntryVM.getInstance()
            .getLatestTaskEntryByTaskId(reminderEntry.taskId);
        if (latestTaskEntry.id == NULL_STRING_PLACEHOLDER) {
          latestTaskEntry = null;
        }
        if (latestTaskEntry != null) {
          // If same year, same month, same day, then means already done for that day
          if (isToday(latestTaskEntry.completedDate)) {
            continue;
          }
        }
        await createNotification(
            reminderEntry.id,
            TaskVM.getInstance().retrieveTaskById(reminderEntry.taskId).name,
            reminderEntry.reminderTime);
      }
    }
    // await createNotification('T0003', 'Testing Title', 'Testing Body', const TimeOfDay(hour: 17, minute: 13));
  }

  Future<void> createNotification(
      String reminderEntryId, String title, TimeOfDay scheduleTime) async {
    int reminderIdInt = int.parse(reminderEntryId.substring(1));

    await _setNotification(reminderIdInt, title, scheduleTime);
    print(
        'ADD reminder for $title (${scheduleTime.hour}:${scheduleTime.minute})');
  }

  Future<void> updateNotification(
      String reminderEntryId, String title, TimeOfDay scheduleTime) async {
    int reminderIdInt = int.parse(reminderEntryId.substring(1));

    await flutterLocalNotificationsPlugin.cancel(reminderIdInt);
    await _setNotification(reminderIdInt, title, scheduleTime);
    print(
        'UPDATE reminder for $title (${scheduleTime.hour}:${scheduleTime.minute})');
  }

  Future<void> cancelNotification(String reminderEntryId) async {
    int reminderIdInt = int.parse(reminderEntryId.substring(1));

    await flutterLocalNotificationsPlugin.cancel(reminderIdInt);
    print('CANCEL reminder');
  }

  Future<void> _setNotification(
      int reminderEntryIdInt, String title, TimeOfDay scheduleTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        reminderEntryIdInt,
        title,
        REMINDER_BODY,
        _nextInstanceOfTimeOfDay(scheduleTime.hour, scheduleTime.minute),
        const NotificationDetails(
          android:
              AndroidNotificationDetails('Daily reminder', 'Daily reminder'),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: false,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOfTimeOfDay(int hour, int day) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, day);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Singapore'));
  }
}
