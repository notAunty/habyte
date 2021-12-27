import 'package:flutter/material.dart';

enum NotifierType {
  userNme,
  userScore,
  userPoint,
  tasksInIdName,
  tasksInIdChecked,
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
    }
  }
}
