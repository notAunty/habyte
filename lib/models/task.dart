import 'package:hive/hive.dart';

part 'hiveAdapter/task.g.dart';

@HiveType(typeId: 0)
class TaskModel {
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

  TaskModel();

  TaskModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        points = json['points'],
        startDate = json['startDate'],
        endDate = json['endDate'];

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "points": points,
        "startDate": startDate,
        "endDate": endDate
      };
}
