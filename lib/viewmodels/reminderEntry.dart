import 'package:habyte/models/reminderEntry.dart';
import 'package:habyte/models/task.dart';
import 'package:habyte/services/notifications.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:habyte/viewmodels/general.dart';
import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/viewmodels/task.dart';
import 'package:habyte/views/constant/constants.dart';

/// **ReminderEntry ViewModel Class**
///
/// Involves:
/// - ReminderEntry Model
/// - CRUD
/// - Other operations
class ReminderEntryVM {
  static final ReminderEntryVM _reminderEntryVM = ReminderEntryVM._internal();
  ReminderEntryVM._internal();

  /// Get the `ReminderEntry` instance for user `CRUD` and other operations
  factory ReminderEntryVM.getInstance() => _reminderEntryVM;

  final General _general = General.getInstance();
  final BoxType _boxType = BoxType.reminderEntry;
  final TaskVM _taskVM = TaskVM.getInstance();
  final Notifiers _notifiers = Notifiers.getInstance();
  final NotifierType _reminderEntriesNotifierType =
      NotifierType.reminderEntries;
  final NotificationHandler _notificationHandler =
      NotificationHandler.getInstance();
  List<ReminderEntry> _currentReminderEntries = [];

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  Future<void> setCurrentReminderEntries(
      List<ReminderEntry> reminderEntryList) async {
    _currentReminderEntries = reminderEntryList;
    await _notificationHandler.init(reminderEntryList);

    for (ReminderEntry reminderEntry in _currentReminderEntries) {
      _notifiers.addNotifierValue(
        _reminderEntriesNotifierType,
        reminderEntry.toMap(),
      );
    }

    print("Reminder Entries - ${_toListOfMap()}");
    print(
        "Reminder Entries Notifier - ${_notifiers.getReminderEntriesNotifier().value}");
  }

  /// **Create ReminderEntry** (`C` in CRUD)
  ///
  /// Create reminderEntry will need to pass a map with the pairs of key and value,
  /// by default the `REMINDER_ENTRY_STATUS` is true when creating, so no need
  /// to pass when creating reminderEntry.
  ///
  /// Below are the keys for creating `ReminderEntry`:
  /// - `REMINDER_ENTRY_TASK_ID`
  /// - `REMINDER_ENTRY_TIME`
  ///
  /// Return the created reminderEntry
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  Future<ReminderEntry> createReminderEntry(
      Map<String, dynamic> reminderEntryJson) async {
    // By default, when a reminderEntry is created, its status is true & tempOffDay is NULL
    reminderEntryJson = {
      ...reminderEntryJson,
      REMINDER_ENTRY_STATUS: true,
      REMINDER_ENTRY_TEMP_OFF_DATE: null,
    };
    ReminderEntry _reminderEntry =
        ReminderEntry.createFromJson(reminderEntryJson);
    _reminderEntry.id = _general.getBoxItemNewId(_boxType);
    _currentReminderEntries.add(_reminderEntry);
    _general.addBoxItem(_boxType, _reminderEntry.id, _reminderEntry);

    // Create new reminder entry will add notification if it's today
    Task _task = _taskVM.retrieveTaskById(_reminderEntry.taskId);
    if (isToday(_task.startDate) || _task.startDate.isBefore(DateTime.now())) {
      await _notificationHandler.createNotification(
        _reminderEntry.id,
        _task.name,
        _reminderEntry.reminderTime,
      );
    }
    _notifiers.addNotifierValue(
      _reminderEntriesNotifierType,
      _reminderEntry.toMap(),
    );

    print("Reminder Entries - ${_toListOfMap()}");
    print(
        "Reminder Entries Notifier - ${_notifiers.getReminderEntriesNotifier().value}");
    return _reminderEntry;
  }

  /// **Retrieve ReminderEntry** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of ReminderEntry`.
  List<ReminderEntry> retrieveAllReminderEntries() => _currentReminderEntries;

  /// **Retrieve ReminderEntry** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Map`
  /// (converted from `ReminderEntry`).
  List<Map<String, dynamic>> retrieveAllReminderEntriesInListOfMap() =>
      _toListOfMap();

  /// **Retrieve ReminderEntry** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `ReminderEntry`.
  ///
  /// Parameter required: `id` from `ReminderEntry`.
  ReminderEntry retrieveReminderEntryById(String id) =>
      _currentReminderEntries.singleWhere(
        (reminderEntry) => reminderEntry.id == id,
        orElse: () => ReminderEntry.nullClass(),
      );

  /// **Retrieve ReminderEntry** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `ReminderEntry`.
  ///
  /// Parameter required: `taskId` from `Task`.
  ReminderEntry retrieveReminderEntryByTaskId(String taskId) =>
      _currentReminderEntries.singleWhere(
        (reminderEntry) => reminderEntry.taskId == taskId,
        orElse: () => ReminderEntry.nullClass(),
      );

  /// **Update ReminderEntry** (`U` in CRUD)
  ///
  /// Update reminderEntry will just need to pass the `id` of the `ReminderEntry`
  /// & a map with the key and value that need to update
  ///
  /// Below are the fields that can be updated:
  /// - `REMINDER_ENTRY_TASK_ID`
  /// - `REMINDER_ENTRY_TIME`
  /// - `REMINDER_ENTRY_TEMP_OFF_DATE`
  ///
  /// Return the updated reminderEntry
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  Future<ReminderEntry> updateReminderEntry(
      String id, Map<String, dynamic> jsonToUpdate) async {
    int _index = _currentReminderEntries
        .indexWhere((reminderEntry) => reminderEntry.id == id);
    // if (_index == -1) // do some alert
    ReminderEntry _updatedReminderEntry = ReminderEntry.fromJson({
      ..._currentReminderEntries[_index].toMap(),
      ...jsonToUpdate,
    });
    _currentReminderEntries[_index] = _updatedReminderEntry;
    _general.updateBoxItem(
        _boxType, _updatedReminderEntry.id, _updatedReminderEntry);

    _notifiers.updateNotifierValue(
        _reminderEntriesNotifierType, _updatedReminderEntry.toMap());


    /// IF status == true:
    ///   IF off reminder today:
    ///     cancel today reminder
    ///   ELSE:
    ///     IF task is change to start today OR before today:
    ///       update the current notification time
    ///     ELSE:
    ///       cancel today reminder
    /// ELSE:
    ///   cancel today reminder
    if (_updatedReminderEntry.status) {
      if (_updatedReminderEntry.tempOffDate != null &&
          isToday(_updatedReminderEntry.tempOffDate)) {
        await _notificationHandler.cancelNotification(_updatedReminderEntry.id);
      } else {
        Task currentTask =
            _taskVM.retrieveTaskById(_updatedReminderEntry.taskId);
        if (isToday(currentTask.startDate) ||
            currentTask.startDate.isBefore(DateTime.now())) {
          await _notificationHandler.updateNotification(
            _updatedReminderEntry.id,
            currentTask.name,
            _updatedReminderEntry.reminderTime,
          );
        } else {
          await _notificationHandler
              .cancelNotification(_updatedReminderEntry.id);
        }
      }
    } else {
      await _notificationHandler.cancelNotification(_updatedReminderEntry.id);
    }

    print("Reminder Entries - ${_toListOfMap()}");
    print(
        "Reminder Entries Notifier - ${_notifiers.getReminderEntriesNotifier().value}");
    return _updatedReminderEntry;
  }

  /// **Delete ReminderEntry** (`D` in CRUD)
  ///
  /// Call this function when need to delete reminderEntry when deleting task
  Future<void> deleteReminderEntry(String taskId) async {
    ReminderEntry removedReminderEntry = _currentReminderEntries.singleWhere(
      (reminderEntry) => reminderEntry.taskId == taskId,
    );
    _general.deleteBoxItem(_boxType, removedReminderEntry.id);

    _notifiers.removeOrDeductNotifierValue(
      _reminderEntriesNotifierType,
      removedReminderEntry.id,
    );

    await _notificationHandler.cancelNotification(removedReminderEntry.id);

    print("Reminder Entries - ${_toListOfMap()}");
    print(
        "Reminder Entries Notifier - ${_notifiers.getReminderEntriesNotifier().value}");
  }

  /// Private function to convert `List of ReminderEntry` to `List of Map`
  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> reminderEntriesInListOfMap = [];
    for (ReminderEntry reminderEntry in _currentReminderEntries) {
      reminderEntriesInListOfMap.add(reminderEntry.toMap());
    }
    return reminderEntriesInListOfMap;
  }
}
