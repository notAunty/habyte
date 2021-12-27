import 'package:habyte/models/task.dart';
import 'package:habyte/models/taskEntry.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:habyte/viewmodels/general.dart';
import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/viewmodels/taskEntry.dart';
import 'package:habyte/views/constant/constants.dart';

/// **Task ViewModel Class**
///
/// Involves:
/// - Task Model
/// - CRUD
/// - Other operations
class TaskVM {
  static final TaskVM _taskVM = TaskVM._internal();
  TaskVM._internal();

  /// Get the `Task` instance for user `CRUD` and other operations
  factory TaskVM.getInstance() => _taskVM;

  final General _general = General.getInstance();
  final BoxType _boxType = BoxType.task;
  final Notifiers _notifiers = Notifiers.getInstance();
  final NotifierType _tasksInIdNameNotifierType = NotifierType.tasksInIdName;
  final NotifierType _tasksInIdCheckedNotifierType =
      NotifierType.tasksInIdChecked;
  List<Task> _currentTasks = [];

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  void setCurrentTasks(List<Task> taskList) {
    _currentTasks = taskList;

    for (Task task in _currentTasks) {
      _notifiers.updateNotifierValue(
          _tasksInIdNameNotifierType, {task.id: task.name});
      TaskEntry? latestTaskEntry =
          TaskEntryVM.getInstance().getLatestTaskEntryByTaskId(task.id);
      if (latestTaskEntry.id == NULL_STRING_PLACEHOLDER) {
        latestTaskEntry = null;
      }
      _notifiers.updateNotifierValue(_tasksInIdCheckedNotifierType, {
        task.id:
            latestTaskEntry != null && isToday(latestTaskEntry.completedDate)
      });
    }
  }

  /// **Create Task** (`C` in CRUD)
  ///
  /// Create task will need to pass a map with the pairs of key and value
  ///
  /// Below are the keys for creating `Task`:
  /// - `TASK_NAME`
  /// - `TASK_POINTS`
  /// - `TASK_START_DATE`
  /// - `TASK_END_DATE` (optional)
  ///
  /// Return the created task
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  Task createTask(Map<String, dynamic> taskJson) {
    Task _task = Task.fromJson(taskJson);
    _task.id = _general.getBoxItemNewId(_boxType);
    _currentTasks.add(_task);
    _general.addBoxItem(_boxType, _task.id, _task);

    _notifiers
        .addNotifierValue(_tasksInIdNameNotifierType, {_task.id: _task.name});
    _notifiers
        .addNotifierValue(_tasksInIdCheckedNotifierType, {_task.id: false});

    return _task;
  }

  /// **Retrieve Task** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Task`.
  List<Task> retrieveAllTasks() => _currentTasks;

  /// **Retrieve Task** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Map`
  /// (converted from `Task`).
  List<Map<String, dynamic>> retrieveAllTasksInListOfMap() => _toListOfMap();

  /// **Retrieve Task** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `Task`.
  ///
  /// Parameter required: `id` from `Task`.
  Task retrieveTaskById(String id) => _currentTasks.singleWhere(
        (task) => task.id == id,
        orElse: () => Task().nullClass(),
      );

  /// **Update Task** (`U` in CRUD)
  ///
  /// Update task will just need to pass the `id` of the `Task` &
  /// a map with the key and value that need to update
  ///
  /// Below are the fields that can be updated:
  /// - `TASK_NAME`
  /// - `TASK_POINTS`
  /// - `TASK_START_DATE`
  /// - `TASK_END_DATE`
  ///
  /// Return the created task
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  Task updateTask(String id, Map<String, dynamic> jsonToUpdate) {
    int _index = _currentTasks.indexWhere((task) => task.id == id);
    // if (_index == -1) // do some alert
    Task _updatedTask = Task.fromJson({
      ..._currentTasks[_index].toMap(),
      ...jsonToUpdate,
    });
    _updatedTask.id = id;
    _currentTasks[_index] = _updatedTask;
    _general.updateBoxItem(_boxType, _updatedTask.id, _updatedTask);

    _notifiers.updateNotifierValue(
        _tasksInIdNameNotifierType, {_updatedTask.id: _updatedTask.name});

    return _updatedTask;
  }

  /// **Delete Task** (`D` in CRUD)
  ///
  /// Call this function when need to delete task
  void deleteTask(String id) {
    _currentTasks.removeWhere((task) => task.id == id);
    _general.deleteBoxItem(_boxType, id);

    _notifiers.removeOrDeductNotifierValue(_tasksInIdNameNotifierType, id);
    _notifiers.removeOrDeductNotifierValue(_tasksInIdCheckedNotifierType, id);
  }

  /// Private function to convert `List of Task` to `List of Map`
  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> tasksInListOfMap = [];
    for (Task task in _currentTasks) {
      tasksInListOfMap.add(task.toMap());
    }
    return tasksInListOfMap;
  }
}
