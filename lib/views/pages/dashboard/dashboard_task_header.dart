import 'package:flutter/material.dart';
import 'package:habyte/utils/date_time.dart';
import 'package:habyte/views/constant/sizes.dart';

class DashboardTaskHeader extends StatelessWidget {
  const DashboardTaskHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(SIDE_PADDING, 16, SIDE_PADDING, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(opacity: 0.5, child: Text(dateFormatter(DateTime.now()))),
          const SizedBox(height: 8),
          Text(
            'To-Do List',
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
