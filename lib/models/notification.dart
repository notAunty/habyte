import 'package:habyte/views/constant/constants.dart';
import 'package:hive/hive.dart';

part 'hiveAdapter/notification.g.dart';

@HiveType(typeId: 2)
class NotificationModel {
  // Example: N00001
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late final String taskId;

  // daily time
  @HiveField(2)
  late final DateTime notificationTime;

  NotificationModel();

  NotificationModel.fromJson(Map<String, dynamic> json)
      : taskId = json[NOTIFICATION_TASKID],
        notificationTime = json[NOTIFICATION_TIME];

  Map<String, dynamic> toMap() => {
        NOTIFICATION_ID: id,
        NOTIFICATION_TASKID: taskId,
        NOTIFICATION_TIME: notificationTime,
      };
}
