import 'package:habyte/models/entry.dart';
import 'package:habyte/models/task.dart';
import 'package:habyte/viewmodels/entries.dart';
import 'package:habyte/viewmodels/general.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/constants.dart';

/// **Task ViewModel Class**
///
/// Involves:
/// - Task Model
/// - CRUD
/// - Other operations
class Tasks {
  static final Tasks _tasks = Tasks._internal();
  Tasks._internal();

  /// Get the `Task` instance for user `CRUD` and other operations
  factory Tasks.getInstance() => _tasks;

  final General _general = General.getInstance();
  final BoxType _boxType = BoxType.task;
  List<TaskModel> _currentTasks = [];

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  void setCurrentTasks(List<TaskModel> taskModelList) =>
      _currentTasks = taskModelList;

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
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void createTask(Map<String, dynamic> taskJson) {
    TaskModel _taskModel = TaskModel.fromJson(taskJson);
    _taskModel.id = _general.getBoxItemNewId(_boxType);
    _currentTasks.add(_taskModel);
    _general.addBoxItem(_boxType, _taskModel.id, _taskModel);
  }

  /// **Retrieve Task** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of TaskModel`.
  List<TaskModel> retrieveAllTasks() => _currentTasks;

  /// **Retrieve Task** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Map`
  /// (converted from `TaskModel`).
  List<Map<String, dynamic>> retrieveAllTasksInListOfMap() => _toListOfMap();

  /// **Retrieve Task** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `TaskModel`.
  ///
  /// Parameter required: `id` from `TaskModel`.
  TaskModel retrieveTaskById(String id) =>
      _currentTasks.singleWhere((taskModel) => taskModel.id == id);

  /// **Update Task** (`U` in CRUD)
  ///
  /// Update task will just need to pass the `id` of the `TaskModel` &
  /// a map with the key and value that need to update
  ///
  /// Below are the fields that can be updated:
  /// - `TASK_NAME`
  /// - `TASK_POINTS`
  /// - `TASK_START_DATE`
  /// - `TASK_END_DATE`
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void updateTask(String id, Map<String, dynamic> jsonToUpdate) {
    int _index = _currentTasks.indexWhere((taskModel) => taskModel.id == id);
    TaskModel _updatedTaskModel = TaskModel.fromJson({
      ..._currentTasks[_index].toMap(),
      ...jsonToUpdate,
    });
    _currentTasks[_index] = _updatedTaskModel;
    _general.updateBoxItem(_boxType, _updatedTaskModel.id, _updatedTaskModel);
  }

  /// **Delete Task** (`D` in CRUD)
  ///
  /// Call this function when need to delete task
  void deleteTask(String id) {
    int index = _currentTasks.indexWhere((taskModel) => taskModel.id == id);
    String removedId = _currentTasks.removeAt(index).id;
    _general.deleteBoxItem(_boxType, removedId);
  }

  /// Private function to convert `List of TaskModel` to `List of Map`
  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> tasksInListOfMap = [];
    for (TaskModel taskModel in _currentTasks) {
      tasksInListOfMap.add(taskModel.toMap());
    }
    return tasksInListOfMap;
  }

  /// This function is used to check all the skipped tasks.
  void checkSkippedTasks() {
    UserVM _userVM = UserVM.getInstance();
    Entries _entries = Entries.getInstance();

    int totalMarksToBeDeducted = 0;
    for (TaskModel taskModel in _currentTasks) {
      EntryModel latestEntry = _entries.getLatestEntryByTaskId(taskModel.id);
      int currentTaskSkippedDays =
          _daysBetween(latestEntry.completedDate, DateTime.now());
      if (currentTaskSkippedDays > 0) {
        totalMarksToBeDeducted += SKIPPED_MARKS_DEDUCTED; // amount to be fixed
      }
    }

    _userVM.minusScore(totalMarksToBeDeducted);
  }

  /// Private function to find days difference.
  int _daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
