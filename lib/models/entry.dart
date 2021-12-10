import 'package:habyte/views/constant/constants.dart';
import 'package:hive/hive.dart';

part 'hiveAdapter/entry.g.dart';

@HiveType(typeId: 3)
class Entry {
  // Example: E00001
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late final String taskId;

  @HiveField(2)
  late final DateTime completedDate;

  Entry();

  Entry.fromJson(Map<String, dynamic> json)
      : taskId = json[ENTRY_TASK_ID],
        completedDate = json[ENTRY_COMPLETED_DATE];

  Map<String, dynamic> toMap() => {
        ENTRY_ID: id,
        ENTRY_TASK_ID: taskId,
        ENTRY_COMPLETED_DATE: completedDate,
      };
}
