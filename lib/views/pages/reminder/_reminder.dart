import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/widgets/text_fields.dart';
import 'package:intl/intl.dart';
import '../../../viewmodels/notification.dart';
import 'package:habyte/views/constant/sizes.dart';
import '../../../viewmodels/task.dart';
import 'package:habyte/views/constant/constants.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final formKey = GlobalKey<FormState>();
  final NotificationDetailVM _notificationVM =
      NotificationDetailVM.getInstance();

  @override
  Widget build(BuildContext context) {
    final notificationList =
        _notificationVM.retrieveAllNotificationDetailsInListOfMap();
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder'),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: TOP_PADDING, width: double.infinity),
        
      ]),
    );
  }
}
