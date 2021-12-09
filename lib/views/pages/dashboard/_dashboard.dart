import 'package:flutter/material.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/dashboard/dashboard_card.dart';
import 'package:habyte/views/pages/dashboard/dashboard_header.dart';
import 'package:habyte/views/pages/dashboard/dashboard_task_list.dart';
import 'package:habyte/views/pages/dashboard/dashboard_task_header.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage
({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: TOP_PADDING, width: double.infinity),
        DashboardHeader(),
        DashboardCard(score: 55),
        DashboardTaskHeader(),
        DashboardTaskList(),
      ],
    );
  }
}