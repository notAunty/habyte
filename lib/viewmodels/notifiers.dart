import 'package:flutter/material.dart';
import 'package:habyte/views/constant/constants.dart';

enum NotifierType {
  userName,
  userAbout,
  userScore,
  userPoint,
  tasks,
  tasksInIdChecked,
  availableRewards,
  redeemedRewards,
  reminderEntries,
}

class Notifiers {
  static final Notifiers _notifierVM = Notifiers._internal();
  Notifiers._internal() {
    // User
    _nameNotifier = ValueNotifier('');
    _aboutNotifier = ValueNotifier('');
    _scoreNotifier = ValueNotifier(0);
    _pointNotifier = ValueNotifier(0);

    // Task
    _tasksNotifier = ValueNotifier([]);
    _tasksInIdCheckedNotifier = ValueNotifier({});

    // Reward
    _availableRewardsNotifier = ValueNotifier([]);
    _redeemedRewardsNotifier = ValueNotifier([]);

    // Reminder Entry
    _reminderEntriesNotifier = ValueNotifier([]);
  }

  /// Get the `NotifierVM` instance.
  factory Notifiers.getInstance() => _notifierVM;

  // User
  late ValueNotifier<String> _nameNotifier;
  ValueNotifier<String> getNameNotifier() => _nameNotifier;
  late ValueNotifier<String> _aboutNotifier;
  ValueNotifier<String> getAboutNotifier() => _aboutNotifier;
  late ValueNotifier<int> _scoreNotifier;
  ValueNotifier<int> getScoreNotifier() => _scoreNotifier;
  late ValueNotifier<int> _pointNotifier;
  ValueNotifier<int> getPointNotifier() => _pointNotifier;

  // Task
  late ValueNotifier<List<Map<String, dynamic>>> _tasksNotifier;
  ValueNotifier<List<Map<String, dynamic>>> getTasksNotifier() =>
      _tasksNotifier;
  late ValueNotifier<Map<String, bool>> _tasksInIdCheckedNotifier;
  ValueNotifier<Map<String, bool>> getTasksInIdCheckedNotifier() =>
      _tasksInIdCheckedNotifier;

  // Reward
  late ValueNotifier<List<Map<String, dynamic>>> _availableRewardsNotifier;
  ValueNotifier<List<Map<String, dynamic>>> getAvailableRewardsNotifier() =>
      _availableRewardsNotifier;
  late ValueNotifier<List<Map<String, dynamic>>> _redeemedRewardsNotifier;
  ValueNotifier<List<Map<String, dynamic>>> getRedeemedRewardsNotifier() =>
      _redeemedRewardsNotifier;

  // Reminder Entry
  late ValueNotifier<List<Map<String, dynamic>>> _reminderEntriesNotifier;
  ValueNotifier<List<Map<String, dynamic>>> getReminderEntriesNotifier() =>
      _reminderEntriesNotifier;

  void addNotifierValue(NotifierType notifierType, Object value) {
    switch (notifierType) {
      case NotifierType.userName:
        // Do NOTHING
        break;
      case NotifierType.userAbout:
        // Do NOTHING
        break;
      case NotifierType.userScore:
        assert(value is int);
        _scoreNotifier.value += value as int;
        break;
      case NotifierType.userPoint:
        assert(value is int);
        _pointNotifier.value += value as int;
        break;
      case NotifierType.tasks:
        assert(value is Map);
        int index = _tasksNotifier.value.indexWhere(
            (taskInMap) => taskInMap[TASK_ID] == (value as Map)[TASK_ID]);
        if (index == -1) {
          _tasksNotifier.value.add(value as Map<String, dynamic>);
          _tasksNotifier.value = List.from(_tasksNotifier.value);
        }
        break;
      case NotifierType.tasksInIdChecked:
        assert(value is Map);
        _tasksInIdCheckedNotifier.value = {
          ..._tasksInIdCheckedNotifier.value,
          ...value as Map
        };
        break;
      case NotifierType.availableRewards:
        assert(value is Map);
        int index = _availableRewardsNotifier.value.indexWhere((rewardInMap) =>
            rewardInMap[REWARD_ID] == (value as Map)[REWARD_ID]);
        if (index == -1) {
          _availableRewardsNotifier.value.add(value as Map<String, dynamic>);
          _availableRewardsNotifier.value =
              List.from(_availableRewardsNotifier.value);
        }
        break;
      case NotifierType.redeemedRewards:
        assert(value is Map);
        int index = _redeemedRewardsNotifier.value.indexWhere((rewardInMap) =>
            rewardInMap[REWARD_ID] == (value as Map)[REWARD_ID]);
        if (index == -1) {
          _redeemedRewardsNotifier.value.add(value as Map<String, dynamic>);
          _redeemedRewardsNotifier.value =
              List.from(_redeemedRewardsNotifier.value);
        }
        break;
      case NotifierType.reminderEntries:
        assert(value is Map);
        int index = _reminderEntriesNotifier.value.indexWhere(
            (reminderEntryInMap) =>
                reminderEntryInMap[REMINDER_ENTRY_ID] ==
                (value as Map)[REMINDER_ENTRY_ID]);
        if (index == -1) {
          _reminderEntriesNotifier.value.add(value as Map<String, dynamic>);
          _reminderEntriesNotifier.value = List.from(
            _reminderEntriesNotifier.value,
          );
        }
        break;
    }
  }

  void updateNotifierValue(NotifierType notifierType, Object value) {
    switch (notifierType) {
      case NotifierType.userName:
        assert(value is String);
        _nameNotifier.value = value as String;
        break;
      case NotifierType.userAbout:
        assert(value is String);
        _aboutNotifier.value = value as String;
        break;
      case NotifierType.userScore:
        assert(value is int);
        _scoreNotifier.value = value as int;
        break;
      case NotifierType.userPoint:
        assert(value is int);
        _pointNotifier.value = value as int;
        break;
      case NotifierType.tasks:
        assert(value is Map);
        int index = _tasksNotifier.value.indexWhere(
            (taskInMap) => taskInMap[TASK_ID] == (value as Map)[TASK_ID]);
        _tasksNotifier.value[index] = value as Map<String, dynamic>;
        _tasksNotifier.value = List.from(_tasksNotifier.value);
        break;
      case NotifierType.tasksInIdChecked:
        assert(value is Map);
        addNotifierValue(notifierType, value);
        break;
      case NotifierType.availableRewards:
        assert(value is Map);
        int index = _availableRewardsNotifier.value.indexWhere((rewardInMap) =>
            rewardInMap[REWARD_ID] == (value as Map)[REWARD_ID]);
        _availableRewardsNotifier.value[index] = value as Map<String, dynamic>;
        _availableRewardsNotifier.value =
            List.from(_availableRewardsNotifier.value);
        break;
      case NotifierType.redeemedRewards:
        assert(value is Map);
        int index = _redeemedRewardsNotifier.value.indexWhere((rewardInMap) =>
            rewardInMap[REWARD_ID] == (value as Map)[REWARD_ID]);
        _redeemedRewardsNotifier.value[index] = value as Map<String, dynamic>;
        _redeemedRewardsNotifier.value =
            List.from(_redeemedRewardsNotifier.value);
        break;
      case NotifierType.reminderEntries:
        assert(value is Map);
        int index = _reminderEntriesNotifier.value.indexWhere(
            (reminderEntryInMap) =>
                reminderEntryInMap[REMINDER_ENTRY_ID] ==
                (value as Map)[REMINDER_ENTRY_ID]);
        _reminderEntriesNotifier.value[index] = value as Map<String, dynamic>;
        _reminderEntriesNotifier.value = List.from(
          _reminderEntriesNotifier.value,
        );
        break;
    }
  }

  void removeOrDeductNotifierValue(NotifierType notifierType, Object value) {
    switch (notifierType) {
      case NotifierType.userName:
        // Do NOTHING
        break;
      case NotifierType.userAbout:
        // Do NOTHING
        break;
      case NotifierType.userScore:
        assert(value is int);
        _scoreNotifier.value -= value as int;
        break;
      case NotifierType.userPoint:
        assert(value is int);
        _pointNotifier.value -= value as int;
        break;
      case NotifierType.tasks:
        assert(value is String);
        _tasksNotifier.value
            .removeWhere((taskInMap) => taskInMap[TASK_ID] == value);
        _tasksNotifier.value = List.from(_tasksNotifier.value);
        break;
      case NotifierType.tasksInIdChecked:
        assert(value is String);
        _tasksInIdCheckedNotifier.value.remove(value as String);
        _tasksInIdCheckedNotifier.value = {..._tasksInIdCheckedNotifier.value};
        break;
      case NotifierType.availableRewards:
        assert(value is String);
        _availableRewardsNotifier.value
            .removeWhere((rewardInMap) => rewardInMap[REWARD_ID] == value);
        _availableRewardsNotifier.value =
            List.from(_availableRewardsNotifier.value);
        break;
      case NotifierType.redeemedRewards:
        assert(value is String);
        _redeemedRewardsNotifier.value
            .removeWhere((rewardInMap) => rewardInMap[REWARD_ID] == value);
        _redeemedRewardsNotifier.value =
            List.from(_redeemedRewardsNotifier.value);
        break;
      case NotifierType.reminderEntries:
        assert(value is String);
        _reminderEntriesNotifier.value.removeWhere((reminderEntryInMap) =>
            reminderEntryInMap[REMINDER_ENTRY_ID] == value);
        _reminderEntriesNotifier.value =
            List.from(_reminderEntriesNotifier.value);
        break;
    }
  }
}
