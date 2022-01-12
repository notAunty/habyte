import 'package:flutter/material.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:intl/intl.dart';

Future<Map<String, dynamic>> showCalendar(BuildContext context,
    {DateTime? startDate}) async {
  Map<String, dynamic> toReturn = {};
  DateTime dateRange = startDate ?? DateTime.now();

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
    toReturn['date'] = date;
    toReturn['dateInputText'] = date != null ? DateFormat('yyyy-MM-dd').format(date) : '';
    // if (endDate != null && endDate!.compareTo(startDate!) < 0) {
    //   endDate = null;
    //   endDateInput.text = '';
    // }
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
    toReturn['timeOfDay'] = time;
    toReturn['timeOfDayInputText'] = time != null ? timeOfDayFormatter(time) : '';
  });

  return toReturn;
}
