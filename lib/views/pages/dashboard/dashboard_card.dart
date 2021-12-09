import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/profile_picture.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SIDE_PADDING, vertical: 8),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: MEMBERSHIP_COLOR[Random().nextInt(MEMBERSHIP_COLOR.length)],
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(
                        SIDE_PADDING * 0.75, 0, 16, 0),
                    child: ProfilePictureHolder(radius: 28, initials: 'JD'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Dear',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Text(
                          'Novice',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: SIDE_PADDING * 0.75),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          score.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'pts',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 28,
                      child: Row(
                        children: [
                          Image.asset('assets/logo/white.png'),
                          const SizedBox(width: 2),
                          Text(
                            'Habyte',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
