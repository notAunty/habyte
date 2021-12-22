import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getDayOfMonthSuffix(int dayNum) {
  if (!(dayNum >= 1 && dayNum <= 31)) {
    return '';
  }

  if (dayNum >= 11 && dayNum <= 13) {
    return 'th';
  }

  switch (dayNum % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

String dateFormatter(DateTime dt) =>
    DateFormat("d'${getDayOfMonthSuffix(dt.day)}' MMMM yyyy").format(dt);

String timeOfDayFormatter(TimeOfDay tod) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm();
  return format.format(dt);
}
