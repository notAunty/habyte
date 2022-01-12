import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:habyte/views/constant/constants.dart';

part 'hiveAdapter/reminderEntry.g.dart';

@HiveType(typeId: 2)
class ReminderEntry {
  // Example: N00001
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late final String taskId;

  @HiveField(2)
  late final bool status;

  // daily time
  @HiveField(3)
  late final TimeOfDay reminderTime;

  ReminderEntry();

  ReminderEntry.createFromJson(Map<String, dynamic> json)
      : status = json[REMINDER_ENTRY_STATUS],
        reminderTime = json[REMINDER_ENTRY_TIME];

  ReminderEntry.fromJson(Map<String, dynamic> json)
      : taskId = json[REMINDER_ENTRY_TASK_ID],
        status = json[REMINDER_ENTRY_STATUS],
        reminderTime = json[REMINDER_ENTRY_TIME];

  Map<String, dynamic> toMap() => {
        REMINDER_ENTRY_ID: id,
        REMINDER_ENTRY_TASK_ID: taskId,
        REMINDER_ENTRY_STATUS: status,
        REMINDER_ENTRY_TIME: reminderTime,
      };

  ReminderEntry.nullClass()
      : id = NULL_STRING_PLACEHOLDER,
        taskId = NULL_STRING_PLACEHOLDER,
        status = NULL_BOOL_PLACEHOLDER,
        reminderTime = TimeOfDay.now();
}
