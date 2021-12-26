import 'package:habyte/models/reminderEntry.dart';
import 'package:habyte/models/taskEntry.dart';
import 'package:habyte/services/notifications.dart';
import 'package:habyte/viewmodels/general.dart';
import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/viewmodels/reminderEntry.dart';
import 'package:habyte/viewmodels/task.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/constants.dart';

/// **TaskEntry ViewModel Class**
///
/// Involves:
/// - TaskEntry Model
/// - CRUD
/// - Other operations
class TaskEntryVM {
  static final TaskEntryVM _taskEntryVM = TaskEntryVM._internal();
  TaskEntryVM._internal();

  /// Get the `TaskEntry` instance for user `CRUD` and other operations
  factory TaskEntryVM.getInstance() => _taskEntryVM;

  final General _general = General.getInstance();
  final BoxType _boxType = BoxType.taskEntry;
  final Notifiers _notifiers = Notifiers.getInstance();
  final NotifierType _currentTaskEntriesNotifierType =
      NotifierType.currentTaskEntries;
  final NotifierType _tasksInIdCheckedNotifierType =
      NotifierType.tasksInIdChecked;
  List<TaskEntry> _currentTaskEntries = [];

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  void setCurrentTaskEntries(List<TaskEntry> taskEntryList) {
    _currentTaskEntries = taskEntryList;
    for (TaskEntry taskEntry in taskEntryList) {
      _notifiers.addNotifierValue(_currentTaskEntriesNotifierType, taskEntry);
    }
  }

  /// **Create TaskEntry** (`C` in CRUD)
  ///
  /// Create taskEntry will need to pass a map with the pairs of key and value
  ///
  /// Below are the keys for creating `TaskEntry`:
  /// - `TASK_ENTRY_TASK_ID`
  ///
  /// Return the created taskEntry
  ///
  /// **Remark:**
  /// - Above keys are gotten from `constant.dart`. Kindly import from there
  /// - Completed Date is not required, because createTaskEntry will definitely
  /// be now
  Future<TaskEntry> createTaskEntry(Map<String, dynamic> taskEntryJson) async {
    TaskEntry _taskEntry = TaskEntry.fromJson(
        {...taskEntryJson, TASK_ENTRY_COMPLETED_DATE: DateTime.now()});
    _taskEntry.id = _general.getBoxItemNewId(_boxType);
    _currentTaskEntries.add(_taskEntry);
    _general.addBoxItem(_boxType, _taskEntry.id, _taskEntry);

    _notifiers.addNotifierValue(_currentTaskEntriesNotifierType, _taskEntry);
    _notifiers.updateNotifierValue(
        _tasksInIdCheckedNotifierType, {_taskEntry.taskId: true});
    UserVM.getInstance().addPointScore(
        TaskVM.getInstance().retrieveTaskById(_taskEntry.taskId).points);

    // Once done create taskEntry, notification for today should be off
    ReminderEntry _reminderEntry = ReminderEntryVM.getInstance()
        .retrieveReminderEntryByTaskId(_taskEntry.taskId);
    if (_reminderEntry.id != NULL_STRING_PLACEHOLDER) {
      await NotificationHandler.getInstance()
          .cancelNotification(_reminderEntry.id);
    }
    return _taskEntry;
  }

  /// **Retrieve TaskEntry** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of TaskEntry`.
  List<TaskEntry> retrieveAllTaskEntries() => _currentTaskEntries;

  /// **Retrieve TaskEntry** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Map`
  /// (converted from `TaskEntry`).
  List<Map<String, dynamic>> retrieveAllTaskEntriesInListOfMap() =>
      _toListOfMap();

  /// **Retrieve TaskEntry** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `TaskEntry`.
  ///
  /// Parameter required: `id` from `TaskEntry`.
  TaskEntry retrieveTaskEntryById(String id) => _currentTaskEntries.singleWhere(
        (taskEntry) => taskEntry.id == id,
        orElse: () => TaskEntry().nullClass(),
      );

  /// **Retrieve TaskEntry** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of TaskEntry` from `taskId`.
  ///
  /// Parameter required: `taskId` from `Task`.
  List<TaskEntry> retrieveTaskEntriesByTaskId(String taskId) =>
      _currentTaskEntries
          .where((taskEntry) => taskEntry.taskId == taskId)
          .toList();

  /// **Update TaskEntry** (`U` in CRUD)
  ///
  /// Update taskEntry will just need to pass the `id` of the `TaskEntry`
  /// & a map with the key and value that need to update
  ///
  /// Below are the fields that can be updated:
  /// - `TASK_ENTRY_TASK_ID`
  /// - `TASK_ENTRY_COMPLETED_DATE`
  ///
  /// Return the updated taskEntry
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  TaskEntry updateTaskEntry(String id, Map<String, dynamic> jsonToUpdate) {
    int _index =
        _currentTaskEntries.indexWhere((taskEntry) => taskEntry.id == id);
    // if (_index == -1) // do some alert
    TaskEntry _updatedTaskEntry = TaskEntry.fromJson({
      ..._currentTaskEntries[_index].toMap(),
      ...jsonToUpdate,
    });
    _updatedTaskEntry.id = id;
    _currentTaskEntries[_index] = _updatedTaskEntry;
    _general.updateBoxItem(_boxType, _updatedTaskEntry.id, _updatedTaskEntry);

    _notifiers.updateNotifierValue(
        _currentTaskEntriesNotifierType, _updatedTaskEntry);

    return _updatedTaskEntry;
  }

  /// **Delete TaskEntry** (`D` in CRUD)
  ///
  /// Call this function when need to delete taskEntry
  void deleteTaskEntry(String id) {
    _currentTaskEntries.removeWhere((taskEntry) => taskEntry.id == id);
    _general.deleteBoxItem(_boxType, id);

    _notifiers.removeOrDeductNotifierValue(_currentTaskEntriesNotifierType, id);
  }

  /// Get the latest taskEntry by Task ID to get the completedDate in order to
  /// check skipped tasks.
  TaskEntry getLatestTaskEntryByTaskId(String taskId) =>
      _currentTaskEntries.lastWhere(
        (taskEntry) => taskEntry.taskId == taskId,
        orElse: () => TaskEntry().nullClass(),
      );

  /// Private function to convert `List of TaskEntry` to `List of Map`
  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> taskEntriesInListOfMap = [];
    for (TaskEntry taskEntry in _currentTaskEntries) {
      taskEntriesInListOfMap.add(taskEntry.toMap());
    }
    return taskEntriesInListOfMap;
  }
}
