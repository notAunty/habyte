import 'package:habyte/views/constant/constants.dart';
import 'package:hive/hive.dart';

part 'hiveAdapter/taskEntry.g.dart';

@HiveType(typeId: 3)
class TaskEntry {
  // Example: E00001
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late final String taskId;

  @HiveField(2)
  late final DateTime completedDate;

  TaskEntry();

  TaskEntry.fromJson(Map<String, dynamic> json)
      : taskId = json[TASK_ENTRY_TASK_ID],
        completedDate = json[TASK_ENTRY_COMPLETED_DATE];

  Map<String, dynamic> toMap() => {
        TASK_ENTRY_ID: id,
        TASK_ENTRY_TASK_ID: taskId,
        TASK_ENTRY_COMPLETED_DATE: completedDate,
      };
}
