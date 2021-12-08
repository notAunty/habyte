import 'package:habyte/models/entry.dart';
import 'package:habyte/models/task.dart';
import 'package:habyte/viewmodels/entries.dart';
import 'package:habyte/viewmodels/general.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/constants.dart';

class Tasks {
  static final Tasks _tasks = Tasks._internal();
  factory Tasks.getInstance() => _tasks;
  Tasks._internal();

  BoxType boxType = BoxType.task;

  final General _general = General.getInstance();

  late final List<TaskModel> _currentTasks;

  void setCurrentTasks(List<TaskModel> taskModelList) {
    _currentTasks = taskModelList;
  }

  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> tasksInListOfMap = [];
    for (TaskModel taskModel in _currentTasks) {
      tasksInListOfMap.add(taskModel.toMap());
    }
    return tasksInListOfMap;
  }

  //// CRUD
  // C
  void createTask(TaskModel taskModel) {
    taskModel.id = _general.getBoxItemNewId(boxType);
    _currentTasks.add(taskModel);
    _general.addBoxItem(boxType, taskModel.id, taskModel);
  }

  // R
  List<TaskModel> retrieveAllTasks() => _currentTasks;
  List<Map<String, dynamic>> retrieveAllTasksInListOfMap() => _toListOfMap();

  // r
  TaskModel retrieveTaskById(String id) =>
      _currentTasks.singleWhere((taskModel) => taskModel.id == id);

  // U
  void updateTask(String id, TaskModel updatedTaskModel) {
    int index = _currentTasks.indexWhere((taskModel) => taskModel.id == id);
    updatedTaskModel.id = _currentTasks[index].id;
    _currentTasks[index] = updatedTaskModel;
    _general.updateBoxItem(boxType, updatedTaskModel.id, updatedTaskModel);
  }

  // D
  void deleteTask(String id) {
    int index = _currentTasks.indexWhere((taskModel) => taskModel.id == id);
    String removedId = _currentTasks.removeAt(index).id;
    _general.deleteBoxItem(boxType, removedId);
  }
  ////

  void checkSkippedTasks() {
    User _user = User.getInstance();
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

    _user.minusScore(totalMarksToBeDeducted);
  }

  int _daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
