import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/entry.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/profile_picture.dart';

class ProfileScoreCard extends StatelessWidget {
  ProfileScoreCard({Key? key}) : super(key: key);

  final UserVM _userVM = UserVM.getInstance();
  final EntryVM _entryVM = EntryVM.getInstance();

  @override
  Widget build(BuildContext context) {
    final String? _userName = _userVM.retrieveUser()!.toMap()[USER_NAME];
    final int? _userScore = _userVM.retrieveUser()!.toMap()[USER_SCORES];
    final int _numOfEntries = _entryVM.retrieveAllEntries().length;

    return Hero(
      tag: 'profile_score_card',
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: SIDE_PADDING, vertical: 8),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            color: MEMBERSHIP_COLOR[Random().nextInt(MEMBERSHIP_COLOR.length)],
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
                    padding: EdgeInsets.fromLTRB(SIDE_PADDING * 0.75, 0, 16, 0),
                    child: ProfilePictureHolder(radius: 28),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userName!,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: WHITE_01),
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Text(
                          // TODO
                          'Novice',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: WHITE_01),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: SIDE_PADDING * 0.75),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          _userScore.toString(),
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
                          _numOfEntries.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: WHITE_01),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'entries',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: SIDE_PADDING * 0.75),
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
  }
}
