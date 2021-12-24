import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/reminderEntry.dart';
import 'package:habyte/views/constant/sizes.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final formKey = GlobalKey<FormState>();
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
