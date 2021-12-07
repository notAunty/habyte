import 'package:habyte/viewmodels/users.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:hive/hive.dart';

class General {
  static final General _general = General._internal();
  factory General.getInstance() => _general;
  General._internal() {
    box = Hive.box(BOX_NAME);
  }

  late Box box;

  bool retrievePreviousLogin() {
    Map<String, String>? userJson =
        Map<String, String>.from(box.get(BOX_USER) ?? {});
    if (userJson.isEmpty) return false;
    User.getInstance().setCurrentUser(userJson);

    return true;
  }
}
