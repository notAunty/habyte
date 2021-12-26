import 'package:flutter/widgets.dart';
import 'package:habyte/models/user.dart';
import 'package:habyte/viewmodels/general.dart';
import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/views/constant/constants.dart';

/// **User ViewModel Class**
///
/// Involves:
/// - User Model
/// - CRUD
/// - Other operations
/// **Remark:**
/// - `Point` can be earned through completing tasks. Is used to redeem rewards.
/// - `Score` is commutative of point. Will get deducted when habit is skipped on a day.
class UserVM {
  static final UserVM _userVM = UserVM._internal();
  UserVM._internal();

  /// Get the `User` instance for user `CRUD` and other operations
  factory UserVM.getInstance() => _userVM;

  final General _general = General.getInstance();
  final BoxType _boxType = BoxType.main;
  final Notifiers _notifiers = Notifiers.getInstance();
  final NotifierType _nameNotifierType = NotifierType.userNme;
  final NotifierType _scoreNotifierType = NotifierType.userScore;
  final NotifierType _pointNotifierType = NotifierType.userPoint;
  final String _key = BOX_USER;
  late User? _currentUser;
  Map<String, dynamic> _tempUserJson = {};

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  void setCurrentUser(Map<String, dynamic> userJson) {
    _currentUser = User.fromJson(userJson);
    _notifiers.updateNotifierValue(_nameNotifierType,
        '${_currentUser!.firstName} ${_currentUser!.lastName}');
    _notifiers.updateNotifierValue(_scoreNotifierType, _currentUser!.scores);
    _notifiers.updateNotifierValue(_pointNotifierType, _currentUser!.points);
  }

  /// Add temp user data, since multiple pages for user registration
  ///
  /// Below are the fields needed during user registration:
  /// - `USER_NAME`
  /// - `USER_ABOUT` (optional)
  /// - `USER_PROFILE_PIC_PATH` (optional)
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void addTempUserData(Map<String, dynamic> tempUserJson) {
    _tempUserJson = {..._tempUserJson, ...tempUserJson};
    //TODO: Remove print
    print(_tempUserJson);
  }

  /// Only call this function during registration.
  Map<String, dynamic> retrieveTempUserJson() => _tempUserJson;

  /// **Create User** (`C` in CRUD)
  ///
  /// Call this function at the last stage after adding all temp user data
  void createUser() {
    _tempUserJson = {
      ..._tempUserJson,
      ...{USER_POINTS: 0, USER_SCORES: 0}
    };
    setCurrentUser(_tempUserJson);
    _general.addBoxItem(_boxType, _key, _tempUserJson);

    _notifiers.updateNotifierValue(_nameNotifierType,
        '${_tempUserJson[USER_FIRST_NAME]} ${_tempUserJson[USER_LAST_NAME]}');
  }

  /// **Retrieve User** (`R` in CRUD)
  ///
  /// Call this function when you need the info, such as `USER_NAME`.
  User? retrieveUser() => _currentUser;

  /// **Update User** (`U` in CRUD)
  ///
  /// Update user will just need to pass a map with the key and value that
  /// need to update
  ///
  /// Below are the fields that can be updated:
  /// - `USER_NAME`
  /// - `USER_ABOUT`
  /// - `USER_PROFILE_PIC_PATH`
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void updateUser(Map<String, dynamic> jsonToUpdate) {
    setCurrentUser({..._currentUser!.toMap(), ...jsonToUpdate});
    _general.addBoxItem(_boxType, _key, _currentUser!.toMap());

    _notifiers.updateNotifierValue(_nameNotifierType,
        '${_currentUser!.firstName} ${_currentUser!.lastName}');
  }

  /// **Delete User** (`D` in CRUD)
  ///
  /// Call this function when user click logout.
  ///
  /// **Remark:** In our case, `logout` == `clear db` as we don't have cloud
  /// database for multiple user structure
  void deleteUser() {
    _currentUser = null;
    _general.deleteBoxItem(_boxType, _key);

    _notifiers.updateNotifierValue(_nameNotifierType, '');
  }

  /// This function is used to add score whenever user done taskEntry.
  void addPointScore(int taskPoint) {
    _currentUser!.scores += taskPoint;
    _currentUser!.points += taskPoint;
    _general.updateBoxItem(_boxType, _key, _currentUser!.toMap());
    print(_currentUser!.toMap());

    _notifiers.addNotifierValue(_scoreNotifierType, taskPoint);
    _notifiers.addNotifierValue(_pointNotifierType, taskPoint);
  }

  /// This function is used to deduct point whenever user redeem reward
  void deductPoint(int redeemedPoint) {
    _currentUser!.points -= redeemedPoint;
    _general.updateBoxItem(_boxType, _key, _currentUser!.toMap());
    print(_currentUser!.toMap());

    _notifiers.removeOrDeductNotifierValue(_pointNotifierType, redeemedPoint);
  }

  /// This function is used to deduct score if user accidentally or intentionally
  /// skip the tasks.
  void deductScore(int numOfScore) {
    if (_currentUser!.scores >= numOfScore) {
      _currentUser!.scores -= numOfScore;
      _notifiers.addNotifierValue(_scoreNotifierType, numOfScore);
    } else {
      _currentUser!.scores = 0;
      _notifiers.updateNotifierValue(_scoreNotifierType, 0);
    }
    _general.updateBoxItem(_boxType, _key, _currentUser!.toMap());
    print(_currentUser!.toMap());
  }
}
