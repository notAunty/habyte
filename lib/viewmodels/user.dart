import 'package:habyte/models/user.dart';

class User {
  static final User _user = User._internal();
  factory User.getInstance() => _user;
  User._internal();

  UserModel? currentUser;

  // create user use same here
  void setCurrentUser(Map<String, dynamic> userJson) =>
      currentUser = UserModel.fromJson(userJson);

  void updateCurrentUser(Map<String, dynamic> newUserJson) =>
      currentUser = UserModel.fromJson(newUserJson);

  void minusScore(int numOfScore) {
    if (currentUser!.scores >= numOfScore) {
      currentUser!.scores -= numOfScore;
    } else {
      currentUser!.scores = 0;
    }
  }
}
