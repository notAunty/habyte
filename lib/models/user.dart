import 'package:habyte/views/constant/constants.dart';

class User {
  late String name;
  late String? about;
  late String? profilePicPath;
  late int points;
  late int scores;

  User.fromJson(Map<String, dynamic> json)
      : name = json[USER_NAME],
        about = json[USER_ABOUT],
        profilePicPath = json[USER_PROFILE_PIC_PATH],
        points = json[USER_POINTS],
        scores = json[USER_SCORES];

  Map<String, dynamic> toMap() => {
        USER_NAME: name,
        USER_ABOUT: about,
        USER_PROFILE_PIC_PATH: profilePicPath,
        USER_POINTS: points,
        USER_SCORES: scores
      };
}
