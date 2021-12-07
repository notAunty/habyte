import 'package:habyte/models/user.dart';

class User {
  static final User _user = User._internal();
  factory User.getInstance() => _user;
  User._internal();

  UserModel? currentUser;

  void setCurrentUser(Map<String, String> userJson) =>
      currentUser = UserModel.fromJson(userJson);
}
