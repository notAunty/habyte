class NotificationModel {
  late final String id;
  late final String taskId;
  late final DateTime notificationTime;

  NotificationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        taskId = json['taskId'],
        notificationTime = json['notificationTime'];

  Map<String, dynamic> toMap() =>
      {"id": id, "taskId": taskId, "notificationTime": notificationTime};
}
