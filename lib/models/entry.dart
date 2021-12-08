import 'package:hive/hive.dart';

part 'hiveAdapter/entry.g.dart';

@HiveType(typeId: 3)
class EntryModel {
  // Example: E00001
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late final String taskId;

  @HiveField(2)
  late final DateTime completedDate;

  EntryModel();

  EntryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        taskId = json['taskId'],
        completedDate = json['completedDate'];

  Map<String, dynamic> toMap() =>
      {"id": id, "taskId": taskId, "completedDate": completedDate};
}
