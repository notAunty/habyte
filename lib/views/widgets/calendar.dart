import 'package:flutter/material.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:intl/intl.dart';

Future<Map<String, dynamic>> showCalendar(BuildContext context,
    {DateTime? startDate, bool isStartDate = true}) async {
  Map<String, dynamic> toReturn = {};
  DateTime dateRange =
      isStartDate ? DateTime.now() : startDate ?? DateTime.now();

  await showDatePicker(
    context: context,
    initialDate: startDate ?? DateTime.now(),
    firstDate: dateRange,
    cancelText: 'Clear',
    lastDate: dateRange.add(const Duration(days: 3650)),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(
            primary: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: child!,
      );
    },
  ).then((date) {
    if (date != null) {
      if (isStartDate) {
        toReturn['startDate'] = date;
        toReturn['startDateInputText'] = DateFormat('yyyy-MM-dd').format(date);
        // if (endDate != null && endDate!.compareTo(startDate!) < 0) {
        //   endDate = null;
        //   endDateInput.text = '';
        // }
      } else {
        toReturn['endDate'] = date;
        toReturn['endDateInputText'] = DateFormat('yyyy-MM-dd').format(date);
      }
    } else {
      if (isStartDate) {
        toReturn['startDate'] = null;
        toReturn['startDateInputText'] = '';
      } else {
        toReturn['endDate'] = null;
        toReturn['endDateInputText'] = '';
      }
    }
  });

  return toReturn;
}

Future<Map<String, dynamic>> showTimeInput(BuildContext context) async {
  Map<String, dynamic> toReturn = {};
  await showTimePicker(
    context: context,
    initialTime: const TimeOfDay(hour: 8, minute: 0),
    initialEntryMode: TimePickerEntryMode.dial,
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(
            primary: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: child!,
      );
    },
  ).then((time) {
    if (time != null) {
      toReturn['reminder'] = time;
      toReturn['reminderInputText'] = timeOfDayFormatter(time);

      print(time.hour);
    }
  });

  return toReturn;
}
