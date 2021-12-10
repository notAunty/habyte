import 'package:habyte/models/notification.dart';
import 'package:habyte/viewmodels/general.dart';

/// **NotificationDetail ViewModel Class**
///
/// Involves:
/// - NotificationDetail Model
/// - CRUD
/// - Other operations
class NotificationDetailVM {
  static final NotificationDetailVM _notificationDetailVM =
      NotificationDetailVM._internal();
  NotificationDetailVM._internal();

  /// Get the `NotificationDetail` instance for user `CRUD` and other operations
  factory NotificationDetailVM.getInstance() => _notificationDetailVM;

  final General _general = General.getInstance();
  final BoxType _boxType = BoxType.notificationDetail;
  List<NotificationDetail> _currentNotificationDetails = [];

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  void setCurrentNotificationDetails(
          List<NotificationDetail> notificationDetailList) =>
      _currentNotificationDetails = notificationDetailList;

  /// **Create NotificationDetail** (`C` in CRUD)
  ///
  /// Create notificationDetail will need to pass a map with the pairs of key and value
  ///
  /// Below are the keys for creating `NotificationDetail`:
  /// - `NOTIFICATION_DETAIL_TASK_ID`
  /// - `NOTIFICATION_DETAIL_TIME`
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void createNotificationDetail(Map<String, dynamic> notificationDetailJson) {
    NotificationDetail _notificationDetail =
        NotificationDetail.fromJson(notificationDetailJson);
    _notificationDetail.id = _general.getBoxItemNewId(_boxType);
    _currentNotificationDetails.add(_notificationDetail);
    _general.addBoxItem(_boxType, _notificationDetail.id, _notificationDetail);
  }

  /// **Retrieve NotificationDetail** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of NotificationDetail`.
  List<NotificationDetail> retrieveAllNotificationDetails() =>
      _currentNotificationDetails;

  /// **Retrieve NotificationDetail** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Map`
  /// (converted from `NotificationDetail`).
  List<Map<String, dynamic>> retrieveAllNotificationDetailsInListOfMap() =>
      _toListOfMap();

  /// **Retrieve NotificationDetail** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `NotificationDetail`.
  ///
  /// Parameter required: `id` from `NotificationDetail`.
  NotificationDetail retrieveNotificationDetailById(String id) =>
      _currentNotificationDetails
          .singleWhere((notificationDetail) => notificationDetail.id == id);

  /// **Retrieve NotificationDetail** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `NotificationDetail`.
  ///
  /// Parameter required: `taskId` from `Task`.
  NotificationDetail retrieveNotificationDetailByTaskId(String taskId) =>
      _currentNotificationDetails.singleWhere(
          (notificationDetail) => notificationDetail.taskId == taskId);

  /// **Update NotificationDetail** (`U` in CRUD)
  ///
  /// Update notificationDetail will just need to pass the `id` of the `NotificationDetail`
  /// & a map with the key and value that need to update
  ///
  /// Below are the fields that can be updated:
  /// - `NOTIFICATION_DETAIL_TASK_ID`
  /// - `NOTIFICATION_DETAIL_TIME`
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void updateNotificationDetail(String id, Map<String, dynamic> jsonToUpdate) {
    int _index = _currentNotificationDetails
        .indexWhere((notificationDetail) => notificationDetail.id == id);
    NotificationDetail _updatedNotificationDetail =
        NotificationDetail.fromJson({
      ..._currentNotificationDetails[_index].toMap(),
      ...jsonToUpdate,
    });
    _currentNotificationDetails[_index] = _updatedNotificationDetail;
    _general.updateBoxItem(
        _boxType, _updatedNotificationDetail.id, _updatedNotificationDetail);
  }

  /// **Delete NotificationDetail** (`D` in CRUD)
  ///
  /// Call this function when need to delete notificationDetail
  void deleteNotificationDetail(String id) {
    int index = _currentNotificationDetails
        .indexWhere((notificationDetail) => notificationDetail.id == id);
    String removedId = _currentNotificationDetails.removeAt(index).id;
    _general.deleteBoxItem(_boxType, removedId);
  }

  /// Private function to convert `List of NotificationDetail` to `List of Map`
  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> notificationDetailsInListOfMap = [];
    for (NotificationDetail notificationDetail in _currentNotificationDetails) {
      notificationDetailsInListOfMap.add(notificationDetail.toMap());
    }
    return notificationDetailsInListOfMap;
  }
}
