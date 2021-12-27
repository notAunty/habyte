import 'package:flutter/material.dart';
import 'package:habyte/views/constant/constants.dart';

enum NotifierType {
  userNme,
  userScore,
  userPoint,
  tasksInIdName,
  tasksInIdChecked,
  availableRewards,
  redeemedRewards
}

class Notifiers {
  static final Notifiers _notifierVM = Notifiers._internal();
  Notifiers._internal() {
    // User
    _nameNotifier = ValueNotifier('');
    _scoreNotifier = ValueNotifier(0);
    _pointNotifier = ValueNotifier(0);

    // Task
    _tasksInIdNameNotifier = ValueNotifier({});
    _tasksInIdCheckedNotifier = ValueNotifier({});

    // Reward
    _availableRewardsNotifier = ValueNotifier([]);
    _redeemedRewardsNotifier = ValueNotifier([]);
  }

  /// Get the `NotifierVM` instance.
  factory Notifiers.getInstance() => _notifierVM;

  // User
  late ValueNotifier<String> _nameNotifier;
  ValueNotifier<String> getNameNotifier() => _nameNotifier;
  late ValueNotifier<int> _scoreNotifier;
  ValueNotifier<int> getScoreNotifier() => _scoreNotifier;
  late ValueNotifier<int> _pointNotifier;
  ValueNotifier<int> getPointNotifier() => _pointNotifier;

  // Task
  late ValueNotifier<Map<String, String>> _tasksInIdNameNotifier;
  ValueNotifier<Map<String, String>> getTasksInIdNameNotifier() =>
      _tasksInIdNameNotifier;
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

  void addNotifierValue(NotifierType notifierType, Object value) {
    switch (notifierType) {
      case NotifierType.userNme:
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
      case NotifierType.tasksInIdName:
        assert(value is Map);
        _tasksInIdNameNotifier.value = {
          ..._tasksInIdNameNotifier.value,
          ...value as Map
        };
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
    }
  }

  void updateNotifierValue(NotifierType notifierType, Object value) {
    switch (notifierType) {
      case NotifierType.userNme:
        assert(value is String);
        _nameNotifier.value = value as String;
        break;
      case NotifierType.userScore:
        assert(value is int);
        _scoreNotifier.value = value as int;
        break;
      case NotifierType.userPoint:
        assert(value is int);
        _pointNotifier.value = value as int;
        break;
      case NotifierType.tasksInIdName:
        assert(value is Map);
        addNotifierValue(notifierType, value);
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
    }
  }

  void removeOrDeductNotifierValue(NotifierType notifierType, Object value) {
    switch (notifierType) {
      case NotifierType.userNme:
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
      case NotifierType.tasksInIdName:
        assert(value is String);
        _tasksInIdNameNotifier.value.remove(value as String);
        _tasksInIdNameNotifier.value = {..._tasksInIdNameNotifier.value};
        break;
      case NotifierType.tasksInIdChecked:
        assert(value is String);
        _tasksInIdCheckedNotifier.value.remove(value as String);
        _tasksInIdCheckedNotifier.value = {..._tasksInIdCheckedNotifier.value};
        break;
      case NotifierType.availableRewards:
        assert(value is Map);
        _availableRewardsNotifier.value.removeWhere((rewardInMap) =>
            rewardInMap[REWARD_ID] == (value as Map)[REWARD_ID]);
        _availableRewardsNotifier.value =
            List.from(_availableRewardsNotifier.value);
        break;
      case NotifierType.redeemedRewards:
        assert(value is Map);
        _redeemedRewardsNotifier.value.removeWhere((rewardInMap) =>
            rewardInMap[REWARD_ID] == (value as Map)[REWARD_ID]);
        _redeemedRewardsNotifier.value =
            List.from(_redeemedRewardsNotifier.value);
        break;
    }
  }
}
