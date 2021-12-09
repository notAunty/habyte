import 'package:flutter/material.dart';
import 'package:habyte/views/constant/sizes.dart';

class DashboardTaskList extends StatelessWidget {
  const DashboardTaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock
    final List<String> mockTasks = [
      'Wake up at 7:00am',
      'Walk 10k steps per day',
      'Sleep at least 8 hours'
    ];
    late List<bool> mockChecked;

    mockChecked = mockTasks.map((e) => false).toList();

    return StatefulBuilder(
      builder: (context, setState) => ListView.builder(
        primary: false,
        shrinkWrap: true,
        padding:
            const EdgeInsets.fromLTRB(SIDE_PADDING - 4, 8, SIDE_PADDING, 0),
        itemCount: mockTasks.length,
        itemBuilder: (context, index) => AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: mockChecked[index] ? 0.5 : 1.0,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0,
            leading: SizedBox(
              width: 32,
              child: mockChecked[index]
                  ? Image.asset('assets/check/checked.png')
                  : Image.asset('assets/check/unchecked.png'),
            ),
            title: Text(
              mockTasks[index],
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  decoration: mockChecked[index]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            onTap: () {
              setState(() {
                mockChecked[index] = !mockChecked[index];
              });
            },
          ),
        ),
      ),
    );
  }
}
