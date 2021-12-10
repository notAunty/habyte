import 'package:habyte/views/constant/constants.dart';
import 'package:hive/hive.dart';

part 'hiveAdapter/notification.g.dart';

@HiveType(typeId: 2)
class NotificationDetail {
  // Example: N00001
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late final String taskId;

  // daily time
  @HiveField(2)
  late final DateTime notificationTime;

  NotificationDetail();

  NotificationDetail.fromJson(Map<String, dynamic> json)
      : taskId = json[NOTIFICATION_DETAIL_TASK_ID],
        notificationTime = json[NOTIFICATION_DETAIL_TIME];

  Map<String, dynamic> toMap() => {
        NOTIFICATION_DETAIL_ID: id,
        NOTIFICATION_DETAIL_TASK_ID: taskId,
        NOTIFICATION_DETAIL_TIME: notificationTime,
      };
}
