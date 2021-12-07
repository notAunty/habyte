import 'package:habyte/models/task.dart';
import 'package:habyte/viewmodels/users.dart';

class Tasks {
  static final Tasks _tasks = Tasks._internal();
  factory Tasks.getInstance() => _tasks;
  Tasks._internal();

  final List<TaskModel> _currentTasks = [];

  void setcurrentTasks(List<Map<String, dynamic>> taskJsonList) {
    for (Map<String, dynamic> taskJson in taskJsonList) {
      _currentTasks.add(TaskModel.fromJson(taskJson));
    }
  }

  List<Map<String, dynamic>> toListOfMap() {
    List<Map<String, dynamic>> tasksInListOfMap = [];
    for (TaskModel taskModel in _currentTasks) {
      tasksInListOfMap.add(taskModel.toMap());
    }
    return tasksInListOfMap;
  }

  //// CRUD
  // C
  void createTask(TaskModel taskModel) => _currentTasks.add(taskModel);

  // R
  List<TaskModel> retrieveAllTasks() => _currentTasks;

  // r
  // Error Handling need to do for this, either do here or do in main code
  TaskModel retrieveTaskById(String id) =>
      _currentTasks.where((taskModel) => taskModel.id == id).toList()[0];

  // U
  void updateTask(String id, TaskModel updatedTaskModel) {
    int index = _currentTasks.indexWhere((taskModel) => taskModel.id == id);
    _currentTasks[index] = updatedTaskModel;
  }

  // D
  void deleteTask(String id) =>
      _currentTasks.removeWhere((taskModel) => taskModel.id == id);
  ////

  void checkSkippedTasks() {
    User currentUser = User.getInstance();

    for (TaskModel taskModel in _currentTasks) {
      int currentTaskSkippedDays =
          _daysBetween(taskModel.lastCompleteDate, DateTime.now());
      if (currentTaskSkippedDays > 0) {
        currentUser.minusScore(0); // amount to be fixed
      }
    }
  }

  int _daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
