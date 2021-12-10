import 'package:habyte/views/constant/constants.dart';
import 'package:hive/hive.dart';

part 'hiveAdapter/task.g.dart';

@HiveType(typeId: 0)
class Task {
  // Example: T00001
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late final String name;

  @HiveField(2)
  late final int points; // I think we can fix it like 1 - 5

  @HiveField(3)
  late final DateTime startDate;

  @HiveField(4)
  late final DateTime? endDate;

  Task();

  Task.fromJson(Map<String, dynamic> json)
      : name = json[TASK_NAME],
        points = json[TASK_POINTS],
        startDate = json[TASK_START_DATE],
        endDate = json[TASK_END_DATE];

  Map<String, dynamic> toMap() => {
        TASK_ID: id,
        TASK_NAME: name,
        TASK_POINTS: points,
        TASK_START_DATE: startDate,
        TASK_END_DATE: endDate
      };
}
