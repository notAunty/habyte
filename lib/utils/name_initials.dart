// import 'dart:math';

import 'package:habyte/views/constant/constants.dart';

String getNameInitials({
  String name = APP_TITLE,
  int initialsLength = 2,
}) {
  assert(initialsLength > 0);
  if (name.isEmpty) return APP_TITLE[0];

  final split = name.split(' ');

  if (split.isNotEmpty) {
    String toReturn = split.map((e) => e[0]).join();
    if (toReturn.length > initialsLength) {
      return toReturn.substring(0, initialsLength);
    }
    return toReturn;
    // String toReturn = '';
    // for (int i = 0; i < min(split.length, initialsLength); i++) {
    //   toReturn += split[i][0];
    // }
    // return toReturn;
  } else {
    // H from Habyte
    return APP_TITLE[0];
  }
}
