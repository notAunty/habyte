import 'package:habyte/models/notification.dart';

class Notifications {
  static final Notifications _notifications = Notifications._internal();
  factory Notifications.getInstance() => _notifications;
  Notifications._internal();

  final List<NotificationModel> _currentNotifications = [];

  void setCurrentNotifications(
      List<Map<String, dynamic>> notificationJsonList) {
    for (Map<String, dynamic> notificationJson in notificationJsonList) {
      _currentNotifications.add(NotificationModel.fromJson(notificationJson));
    }
  }

  List<Map<String, dynamic>> toListOfMap() {
    List<Map<String, dynamic>> notificationsInListOfMap = [];
    for (NotificationModel notificationModel in _currentNotifications) {
      notificationsInListOfMap.add(notificationModel.toMap());
    }
    return notificationsInListOfMap;
  }

  //// CRUD
  // C
  void createNotification(NotificationModel notificationModel) =>
      _currentNotifications.add(notificationModel);

  // R
  List<NotificationModel> retrieveAllNotifications() => _currentNotifications;

  // r
  // Error Handling need to do for this, either do here or do in main code
  NotificationModel retrieveNotificationById(String id) => _currentNotifications
      .where((notificationModel) => notificationModel.id == id)
      .toList()[0];

  NotificationModel retrieveNotificationByTaskId(String taskId) =>
      _currentNotifications
          .where((notificationModel) => notificationModel.taskId == taskId)
          .toList()[0];

  // U
  void updateNotification(
      String id, NotificationModel updatedNotificationModel) {
    int index = _currentNotifications
        .indexWhere((notificationModel) => notificationModel.id == id);
    _currentNotifications[index] = updatedNotificationModel;
  }

  // D
  void deleteNotification(String id) => _currentNotifications
      .removeWhere((notificationModel) => notificationModel.id == id);
  ////
}
