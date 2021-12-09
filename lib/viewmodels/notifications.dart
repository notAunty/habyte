import 'package:habyte/models/notification.dart';
import 'package:habyte/viewmodels/general.dart';

/// **Notification ViewModel Class**
///
/// Involves:
/// - Notification Model
/// - CRUD
/// - Other operations
class Notifications {
  static final Notifications _notifications = Notifications._internal();
  Notifications._internal();

  /// Get the `Notification` instance for user `CRUD` and other operations
  factory Notifications.getInstance() => _notifications;

  final General _general = General.getInstance();
  final BoxType _boxType = BoxType.notification;
  List<NotificationModel> _currentNotifications = [];

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  void setCurrentNotifications(List<NotificationModel> notificationModelList) =>
      _currentNotifications = notificationModelList;

  /// **Create Reward** (`C` in CRUD)
  ///
  /// Create notification will need to pass a map with the pairs of key and value
  ///
  /// Below are the keys for creating `Notification`:
  /// - `NOTIFICATION_TASK_ID`
  /// - `NOTIFICATION_TIME`
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void createNotification(Map<String, dynamic> notificationJson) {
    NotificationModel _notificationModel =
        NotificationModel.fromJson(notificationJson);
    _notificationModel.id = _general.getBoxItemNewId(_boxType);
    _currentNotifications.add(_notificationModel);
    _general.addBoxItem(_boxType, _notificationModel.id, _notificationModel);
  }

  /// **Retrieve Notification** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of NotificationModel`.
  List<NotificationModel> retrieveAllNotifications() => _currentNotifications;

  /// **Retrieve Notification** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Map`
  /// (converted from `NotificationModel`).
  List<Map<String, dynamic>> retrieveAllNotificationsInListOfMap() =>
      _toListOfMap();

  /// **Retrieve Notification** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `NotificationModel`.
  ///
  /// Parameter required: `id` from `NotificationModel`.
  NotificationModel retrieveNotificationById(String id) => _currentNotifications
      .singleWhere((notificationModel) => notificationModel.id == id);

  /// **Retrieve Notification** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `NotificationModel`.
  ///
  /// Parameter required: `taskId` from `TaskModel`.
  NotificationModel retrieveNotificationByTaskId(String taskId) =>
      _currentNotifications.singleWhere(
          (notificationModel) => notificationModel.taskId == taskId);

  /// **Update Notification** (`U` in CRUD)
  ///
  /// Update notification will just need to pass the `id` of the `NotificationModel`
  /// & a map with the key and value that need to update
  ///
  /// Below are the fields that can be updated:
  /// - `NOTIFICATION_TASK_ID`
  /// - `NOTIFICATION_TIME`
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void updateNotification(String id, Map<String, dynamic> jsonToUpdate) {
    int _index = _currentNotifications
        .indexWhere((notificationModel) => notificationModel.id == id);
    NotificationModel _updatedNotificationModel = NotificationModel.fromJson({
      ..._currentNotifications[_index].toMap(),
      ...jsonToUpdate,
    });
    _currentNotifications[_index] = _updatedNotificationModel;
    _general.updateBoxItem(
        _boxType, _updatedNotificationModel.id, _updatedNotificationModel);
  }

  /// **Delete Notification** (`D` in CRUD)
  ///
  /// Call this function when need to delete notification
  void deleteNotification(String id) {
    int index = _currentNotifications
        .indexWhere((notificationModel) => notificationModel.id == id);
    String removedId = _currentNotifications.removeAt(index).id;
    _general.deleteBoxItem(_boxType, removedId);
  }

  /// Private function to convert `List of NotificationModel` to `List of Map`
  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> notificationsInListOfMap = [];
    for (NotificationModel notificationModel in _currentNotifications) {
      notificationsInListOfMap.add(notificationModel.toMap());
    }
    return notificationsInListOfMap;
  }
}
