import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habyte/main.dart';
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

  Future init() async {
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
    // await createNotification('T0003', 'Testing Title', 'Testing Body', const TimeOfDay(hour: 17, minute: 13));
  }

  Future<void> createNotification(
      String reminderId, String title, String body, TimeOfDay scheduleTime) async {
    int reminderIdInt = int.parse(reminderId.substring(1));

    await _setNotification(reminderIdInt, title, body, scheduleTime);
    print(
        'ADD reminder for $title (${scheduleTime.hour}:${scheduleTime.minute})');
  }

  Future<void> updateNotification(
      String reminderId, String title, String body, TimeOfDay scheduleTime) async {
    int reminderIdInt = int.parse(reminderId.substring(1));

    await flutterLocalNotificationsPlugin.cancel(reminderIdInt);
    await _setNotification(reminderIdInt, title, body, scheduleTime);
    print(
        'UPDATE reminder for $title (${scheduleTime.hour}:${scheduleTime.minute})');
  }

  Future<void> cancelNotification(
      String taskId, String title, String body, TimeOfDay scheduleTime) async {
    int taskIdInt = int.parse(taskId.substring(1));

    await flutterLocalNotificationsPlugin.cancel(taskIdInt);
    print(
        'CANCEL reminder for $title (${scheduleTime.hour}:${scheduleTime.minute})');
  }

  Future<void> _setNotification(
      int taskIdInt, String title, String body, TimeOfDay scheduleTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        taskIdInt,
        title,
        body,
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
