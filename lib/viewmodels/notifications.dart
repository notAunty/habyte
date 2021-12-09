import 'package:habyte/models/notification.dart';
import 'package:habyte/viewmodels/general.dart';

class Notifications {
  static final Notifications _notifications = Notifications._internal();
  factory Notifications.getInstance() => _notifications;
  Notifications._internal();

  BoxType boxType = BoxType.notification;

  final General _general = General.getInstance();

  late final List<NotificationModel> _currentNotifications;

  void setCurrentNotifications(List<NotificationModel> notificationModelList) {
    _currentNotifications = notificationModelList;
  }

  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> notificationsInListOfMap = [];
    for (NotificationModel notificationModel in _currentNotifications) {
      notificationsInListOfMap.add(notificationModel.toMap());
    }
    return notificationsInListOfMap;
  }

  //// CRUD
  // C
  void createNotification(NotificationModel notificationModel) {
    notificationModel.id = _general.getBoxItemNewId(BoxType.notification);
    _currentNotifications.add(notificationModel);
    _general.addBoxItem(boxType, notificationModel.id, notificationModel);
  }

  // R
  List<NotificationModel> retrieveAllNotifications() => _currentNotifications;
  List<Map<String, dynamic>> retrieveAllNotificationsInListOfMap() =>
      _toListOfMap();

  // r
  NotificationModel retrieveNotificationById(String id) => _currentNotifications
      .singleWhere((notificationModel) => notificationModel.id == id);

  NotificationModel retrieveNotificationByTaskId(String taskId) =>
      _currentNotifications.singleWhere(
          (notificationModel) => notificationModel.taskId == taskId);

  // U
  void updateNotification(
      String id, NotificationModel updatedNotificationModel) {
    int index = _currentNotifications
        .indexWhere((notificationModel) => notificationModel.id == id);
    updatedNotificationModel.id = _currentNotifications[index].id;
    _currentNotifications[index] = updatedNotificationModel;
    _general.updateBoxItem(
        boxType, updatedNotificationModel.id, updatedNotificationModel);
  }

  // D
  void deleteNotification(String id) {
    int index = _currentNotifications
        .indexWhere((notificationModel) => notificationModel.id == id);
    String removedId = _currentNotifications.removeAt(index).id;
    _general.deleteBoxItem(boxType, removedId);
  }
  ////
}
