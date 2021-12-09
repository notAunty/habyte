import 'package:habyte/models/user.dart';
import 'package:habyte/viewmodels/general.dart';
import 'package:habyte/views/constant/constants.dart';

class User {
  static final User _user = User._internal();
  factory User.getInstance() => _user;
  User._internal();

  BoxType boxType = BoxType.main;

  String key = BOX_USER;

  final General _general = General.getInstance();

  UserModel? currentUser;

  // create user use same here
  void setCurrentUser(Map<String, dynamic> userJson) =>
      currentUser = UserModel.fromJson(userJson);

  void updateCurrentUser(Map<String, dynamic> newUserJson) =>
      currentUser = UserModel.fromJson(newUserJson);

  void editProfilePicture(String profilePicPath) {
    currentUser!.profilePicPath = profilePicPath;
    _general.updateBoxItem(boxType, key, currentUser!.toMap());
  }

  void minusScore(int numOfScore) {
    if (currentUser!.scores >= numOfScore) {
      currentUser!.scores -= numOfScore;
    } else {
      currentUser!.scores = 0;
    }
    _general.updateBoxItem(boxType, key, currentUser!.toMap());
  }
}
