import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habyte/utils/membership_tier.dart';
import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/double_value_listenable_builder.dart';
import 'package:habyte/views/widgets/profile_picture.dart';

class ProfileScoreCard extends StatelessWidget {
  ProfileScoreCard({Key? key, this.heroTag}) : super(key: key);

  final Object? heroTag;
  final Notifiers _notifiers = Notifiers.getInstance();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _notifiers.getNameNotifier(),
      builder: (_, userName, __) {
        return DoubleValueListenableBuilder<int, int>(
            firstValueListenable: _notifiers.getPointNotifier(),
            secondValueListenable: _notifiers.getScoreNotifier(),
            builder: (context, point, score) {
              return Hero(
                tag: heroTag ?? Random.secure().nextDouble(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SIDE_PADDING, vertical: 8),
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      // color: MEMBERSHIP_COLOR[Random().nextInt(MEMBERSHIP_COLOR.length)],
                      color: getCardColorByScores(score),
                      borderRadius: BorderRadius.circular(BORDER_RADIUS),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(
                                  SIDE_PADDING * 0.75, 0, 16, 0),
                              child: ProfilePictureHolder(radius: 28),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(color: WHITE_01),
                                        overflow: TextOverflow.ellipsis,
                                  ),
                                  Opacity(
                                    opacity: 0.7,
                                    child: Text(
                                      getMembershipTierByScores(score),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: WHITE_01),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: SIDE_PADDING * 0.75),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    point.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(color: WHITE_01),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'pts',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: WHITE_01),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    score.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(color: WHITE_01),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'scores',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: WHITE_01),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: SIDE_PADDING * 0.75),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 12,
                                child: Row(
                                  children: [
                                    Image.asset('assets/logo/white.png'),
                                    const SizedBox(width: 2),
                                    Text(
                                      'Habyte',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: WHITE_01),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: SIDE_PADDING * 0.75,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
