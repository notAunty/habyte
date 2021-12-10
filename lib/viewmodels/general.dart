import 'package:habyte/models/entry.dart';
import 'package:habyte/models/notification.dart';
import 'package:habyte/models/reward.dart';
import 'package:habyte/models/task.dart';
// import 'package:habyte/models/user.dart';
import 'package:habyte/viewmodels/entries.dart';
import 'package:habyte/viewmodels/notifications.dart';
import 'package:habyte/viewmodels/rewards.dart';
import 'package:habyte/viewmodels/tasks.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:hive/hive.dart';

enum BoxType { main, task, reward, notificationDetail, entry }

class General {
  static final General _general = General._internal();
  factory General.getInstance() => _general;
  General._internal() {
    _mainBox = Hive.box(BOX_NAME);
    _taskBox = Hive.box<Task>(BOX_TASK);
    _rewardBox = Hive.box<Reward>(BOX_REWARD);
    _notificationDetailBox = Hive.box<NotificationDetail>(BOX_NOTIFICATION_DETAIL);
    _entryBox = Hive.box<EntryModel>(BOX_ENTRY);
  }

  late Box _mainBox;
  late Box<Task> _taskBox;
  late Box<Reward> _rewardBox;
  late Box<NotificationDetail> _notificationDetailBox;
  late Box<EntryModel> _entryBox;

  bool retrievePreviousLogin() {
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

    List<Task> taskList = _taskBox.values.toList();
    if (taskList.isNotEmpty) {
      TaskVM.getInstance().setCurrentTasks(taskList);
    }

    List<Reward> rewardList = _rewardBox.values.toList();
    if (rewardList.isNotEmpty) {
      RewardVM.getInstance().setCurrentRewards(rewardList);
    }

    List<NotificationDetail> notificationDetailList =
        _notificationDetailBox.values.toList();
    if (notificationDetailList.isNotEmpty) {
      NotificationDetailVM.getInstance()
          .setCurrentNotificationDetails(notificationDetailList);
    }

    List<EntryModel> entryModelList = _entryBox.values.toList();
    if (entryModelList.isNotEmpty) {
      Entries.getInstance().setCurrentEntries(entryModelList);
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
      case BoxType.notificationDetail:
        return _notificationDetailBox;
      case BoxType.entry:
        return _entryBox;
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
    String id = box.getAt(box.length - 1).id;
    int numId = int.parse(id.substring(1));
    int newNumId = numId + 1;

    Map<BoxType, String> boxTypeMap = {
      BoxType.task: "T",
      BoxType.reward: "R",
      BoxType.notificationDetail: "N",
      BoxType.entry: "E"
    };

    String? newId = boxTypeMap[box];
    for (var i = 0; i < MODEL_ID_LENGTH - newNumId.toString().length; i++) {
      newId = newId! + "0";
    }
    newId = newId! + newNumId.toString();

    return newId;
  }
}
