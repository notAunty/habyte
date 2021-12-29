import 'package:flutter/material.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/viewmodels/reminderEntry.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({ Key? key }) : super(key: key);
  final ReminderEntryVM _reminderEntryVM = ReminderEntryVM.getInstance();

  @override
  Widget build(BuildContext context) {
    final _reminderEntryList =
        _reminderEntryVM.retrieveAllReminderEntriesInListOfMap();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder'),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        SizedBox(height: TOP_PADDING, width: double.infinity),
      ]),
    );
  }
}