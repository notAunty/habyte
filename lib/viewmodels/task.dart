import 'package:habyte/models/taskEntry.dart';
import 'package:habyte/models/task.dart';
import 'package:habyte/viewmodels/taskEntry.dart';
import 'package:habyte/viewmodels/general.dart';
import 'package:habyte/viewmodels/user.dart';
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
  List<Task> _currentTasks = [];

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  void setCurrentTasks(List<Task> taskList) => _currentTasks = taskList;

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
    Task _task = Task.fromJson(taskJson);
    _task.id = _general.getBoxItemNewId(_boxType);
    _currentTasks.add(_task);
    _general.addBoxItem(_boxType, _task.id, _task);
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
  Task retrieveTaskById(String id) =>
      _currentTasks.singleWhere((task) => task.id == id);

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
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void updateTask(String id, Map<String, dynamic> jsonToUpdate) {
    int _index = _currentTasks.indexWhere((task) => task.id == id);
    Task _updatedTask = Task.fromJson({
      ..._currentTasks[_index].toMap(),
      ...jsonToUpdate,
    });
    _currentTasks[_index] = _updatedTask;
    _general.updateBoxItem(_boxType, _updatedTask.id, _updatedTask);
  }

  /// **Delete Task** (`D` in CRUD)
  ///
  /// Call this function when need to delete task
  void deleteTask(String id) {
    int index = _currentTasks.indexWhere((task) => task.id == id);
    String removedId = _currentTasks.removeAt(index).id;
    _general.deleteBoxItem(_boxType, removedId);
  }

  /// Private function to convert `List of Task` to `List of Map`
  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> tasksInListOfMap = [];
    for (Task task in _currentTasks) {
      tasksInListOfMap.add(task.toMap());
    }
    return tasksInListOfMap;
  }

  /// This function is used to check all the skipped tasks.
  void checkSkippedTasks() {
    UserVM _userVM = UserVM.getInstance();
    TaskEntryVM _taskEntryVM = TaskEntryVM.getInstance();

    int totalMarksToBeDeducted = 0;
    for (Task task in _currentTasks) {
      TaskEntry latestTaskEntry =
          _taskEntryVM.getLatestTaskEntryByTaskId(task.id);
      int currentTaskSkippedDays =
          _daysBetween(latestTaskEntry.completedDate, DateTime.now());
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
