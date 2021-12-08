import 'package:hive/hive.dart';

part 'hiveAdapter/notification.g.dart';

@HiveType(typeId: 2)
class NotificationModel {
  // Example: N00001
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late final String taskId;

  @HiveField(2)
  late final DateTime notificationTime;

  NotificationModel();

  NotificationModel.fromJson(Map<String, dynamic> json)
      : taskId = json['taskId'],
        notificationTime = json['notificationTime'];

  Map<String, dynamic> toMap() =>
      {"id": id, "taskId": taskId, "notificationTime": notificationTime};
}
