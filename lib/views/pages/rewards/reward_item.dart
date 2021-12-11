import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';

class RewardItem extends StatelessWidget {
  const RewardItem({Key? key, required this.points, required this.name})
      : super(key: key);

  final int points;
  final String name;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      leading: Container(
        width: 64,
        color: YELLOW_01.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                points.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
              Text('pts'),
            ],
          ),
        ),
      ),
      tileColor: WHITE_01,
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(name, style: Theme.of(context).textTheme.headline6),
      ),
    );
  }
}
