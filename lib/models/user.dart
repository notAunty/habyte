import 'package:habyte/views/constant/constants.dart';

class User {
  late String firstName;
  late String lastName;
  late String? about;
  late String? profilePicPath;
  late int points;
  late int scores;
  late DateTime? lastScoreDeductedDateTime;

  User.fromJson(Map<String, dynamic> json)
      : firstName = json[USER_FIRST_NAME],
        lastName = json[USER_LAST_NAME],
        about = json[USER_ABOUT],
        profilePicPath = json[USER_PROFILE_PIC_PATH],
        points = json[USER_POINTS],
        scores = json[USER_SCORES],
        lastScoreDeductedDateTime = json[USER_LAST_SCORE_DEDUCTED_DATE_TIME];

  Map<String, dynamic> toMap() => {
        USER_FIRST_NAME: firstName,
        USER_LAST_NAME: lastName,
        USER_ABOUT: about,
        USER_PROFILE_PIC_PATH: profilePicPath,
        USER_POINTS: points,
        USER_SCORES: scores,
        USER_LAST_SCORE_DEDUCTED_DATE_TIME: lastScoreDeductedDateTime
      };
}
