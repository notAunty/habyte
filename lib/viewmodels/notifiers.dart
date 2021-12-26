import 'package:flutter/material.dart';
import 'package:habyte/models/taskEntry.dart';

enum NotifierType {
  userNme,
  userScore,
  userPoint,
  tasksInIdName,
  tasksInIdChecked,
  numEntries,
  currentTaskEntries
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

    // Task Entry
    _numEntriesNotifier = ValueNotifier(0);
    _currentTaskEntriesNotifier = ValueNotifier([]);
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

  // Task Entry
  late ValueNotifier<int> _numEntriesNotifier;
  ValueNotifier<int> getNumEntriesNotifier() => _numEntriesNotifier;

  late ValueNotifier<List<TaskEntry>> _currentTaskEntriesNotifier;
  ValueNotifier<List<TaskEntry>> getCurrentTaskEntriesNotifier() =>
      _currentTaskEntriesNotifier;

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
      case NotifierType.numEntries:
        // Do NOTHING
        break;
      case NotifierType.currentTaskEntries:
        assert(value is TaskEntry);
        _currentTaskEntriesNotifier.value.add(value as TaskEntry);
        _currentTaskEntriesNotifier.value =
            List.from(_currentTaskEntriesNotifier.value);
        _numEntriesNotifier.value += 1;
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
      case NotifierType.numEntries:
        assert(value is int);
        _numEntriesNotifier.value = value as int;
        break;
      case NotifierType.currentTaskEntries:
        assert(value is TaskEntry);
        int index = _currentTaskEntriesNotifier.value
            .indexWhere((taskEntry) => taskEntry.id == (value as TaskEntry).id);
        _currentTaskEntriesNotifier.value[index] = value as TaskEntry;
        _currentTaskEntriesNotifier.value =
            List.from(_currentTaskEntriesNotifier.value);
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
      case NotifierType.numEntries:
        // Do NOTHING
        break;
      case NotifierType.currentTaskEntries:
        assert(value is String);
        _currentTaskEntriesNotifier.value
            .removeWhere((taskEntry) => taskEntry.id == value as String);
        _currentTaskEntriesNotifier.value =
            List.from(_currentTaskEntriesNotifier.value);
        _numEntriesNotifier.value -= 1;
        break;
    }
  }
}
