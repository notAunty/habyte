import 'package:habyte/models/taskEntry.dart';
import 'package:habyte/models/reminderEntry.dart';
import 'package:habyte/models/reward.dart';
import 'package:habyte/models/task.dart';
import 'package:habyte/utils/date_time.dart';
// import 'package:habyte/models/user.dart';
import 'package:habyte/viewmodels/taskEntry.dart';
import 'package:habyte/viewmodels/reminderEntry.dart';
import 'package:habyte/viewmodels/reward.dart';
import 'package:habyte/viewmodels/task.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:hive/hive.dart';

enum BoxType { main, task, reward, reminderEntry, taskEntry }

class General {
  static final General _general = General._internal();
  factory General.getInstance() => _general;
  General._internal() {
    _mainBox = Hive.box(BOX_NAME);
    _taskBox = Hive.box<Task>(BOX_TASK);
    _rewardBox = Hive.box<Reward>(BOX_REWARD);
    _taskEntryBox = Hive.box<TaskEntry>(BOX_TASK_ENTRY);
    _reminderEntryBox = Hive.box<ReminderEntry>(BOX_REMINDER_ENTRY);
  }

  late Box _mainBox;
  late Box<Task> _taskBox;
  late Box<Reward> _rewardBox;
  late Box<TaskEntry> _taskEntryBox;
  late Box<ReminderEntry> _reminderEntryBox;

  Future<bool> retrievePreviousLogin() async {
    // Map<String, dynamic> u = {
    //   "name": "helloworld",
    //   "phoneNumber": "01234",
    //   "emailAddress": "abc@abc.com",
    //   "points": 0,
    //   "scores": 0
    // };
    // User us = User.fromJson(u);
    // _mainBox.put(BOX_USER, us.toMap());

    Map<String, dynamic>? userJson =
        Map<String, dynamic>.from(_mainBox.get(BOX_USER) ?? {});
    if (userJson.isEmpty) return false;
    UserVM.getInstance().setCurrentUser(userJson);

    List<TaskEntry> taskEntryList = _taskEntryBox.values.toList();
    if (taskEntryList.isNotEmpty) {
      TaskEntryVM.getInstance().setCurrentTaskEntries(taskEntryList);
    }

    List<Task> taskList = _taskBox.values.toList();
    if (taskList.isNotEmpty) {
      TaskVM.getInstance().setCurrentTasks(taskList);
      checkSkippedTasks();
    }

    List<Reward> rewardList = _rewardBox.values.toList();
    if (rewardList.isNotEmpty) {
      RewardVM.getInstance().setCurrentRewards(rewardList);
    }

    List<ReminderEntry> reminderEntryList = _reminderEntryBox.values.toList();
    if (reminderEntryList.isNotEmpty) {
      await ReminderEntryVM.getInstance()
          .setCurrentReminderEntries(reminderEntryList);
    }

    return true;
  }

  Box _getBoxByBoxType(BoxType boxType) {
    switch (boxType) {
      case BoxType.main:
        return _mainBox;
      case BoxType.task:
        return _taskBox;
      case BoxType.reward:
        return _rewardBox;
      case BoxType.reminderEntry:
        return _reminderEntryBox;
      case BoxType.taskEntry:
        return _taskEntryBox;
    }
  }

  void addBoxItem(BoxType boxType, String key, Object value) {
    Box box = _getBoxByBoxType(boxType);
    box.put(key, value);
  }

  void updateBoxItem(BoxType boxType, String key, Object value) =>
      addBoxItem(boxType, key, value);

  void deleteBoxItem(BoxType boxType, String key) {
    Box box = _getBoxByBoxType(boxType);
    box.delete(key);
  }

  String getBoxItemNewId(BoxType boxType) {
    Box box = _getBoxByBoxType(boxType);
    int boxLength = box.length;
    int newNumId;
    if (boxLength > 0) {
      String id = box.getAt(boxLength - 1).id;
      int numId = int.parse(id.substring(1));
      newNumId = numId + 1;
    } else {
      newNumId = 1;
    }

    Map<BoxType, String> boxTypeMap = {
      BoxType.task: "T",
      BoxType.reward: "R",
      BoxType.reminderEntry: "N",
      BoxType.taskEntry: "E"
    };

    String? newId = boxTypeMap[boxType];
    for (var i = 0; i < MODEL_ID_LENGTH - newNumId.toString().length; i++) {
      newId = newId! + "0";
    }
    newId = newId! + newNumId.toString();

    return newId;
  }

  /// This function is used to check all the skipped tasks.
  void checkSkippedTasks() {
    int totalScoresToBeDeducted = 0;

    if (!isToday(
        UserVM.getInstance().retrieveUser()!.lastScoreDeductedDateTime)) {
      for (Task task in TaskVM.getInstance().retrieveAllTasks()) {
        TaskEntry latestTaskEntry =
            TaskEntryVM.getInstance().getLatestTaskEntryByTaskId(task.id);
        if (latestTaskEntry.id != NULL_STRING_PLACEHOLDER) {
          int currentTaskSkippedDays =
              _daysBetween(latestTaskEntry.completedDate, DateTime.now());
          if (currentTaskSkippedDays > 0) {
            // amount to be fixed
            totalScoresToBeDeducted += SKIPPED_MARKS_DEDUCTED;
          }
        }
      }

      UserVM.getInstance().deductScore(totalScoresToBeDeducted);
      UserVM.getInstance().updateUser({
        USER_LAST_SCORE_DEDUCTED_DATE_TIME: DateTime.now(),
      });
      print(UserVM.getInstance().retrieveUser()!.toMap());
    }
  }

  /// Private function to find days difference.
  int _daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
