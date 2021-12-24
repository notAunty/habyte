import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/app_logo.dart';
import 'package:habyte/views/widgets/profile_picture.dart';

class ShareRewardCard extends StatelessWidget {
  ShareRewardCard({
    Key? key,
    required this.rewardId,
  }) : super(key: key);

  final String rewardId;

  final UserVM _userVM = UserVM.getInstance();

  @override
  Widget build(BuildContext context) {
    final String _userName = _userVM.retrieveUser()!.toMap()[USER_NAME];

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: SIDE_PADDING, vertical: 8),
      child: Container(
        height: 320,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: TOP_PADDING,
            ),
            SizedBox(
              height: TOP_PADDING * 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(SIDE_PADDING * 0.75, 0, 16, 0),
                    child: Row(
                      children: [
                        const ProfilePictureHolder(radius: 16),
                        const SizedBox(width: 8),
                        Text(
                          _userName,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: WHITE_01,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, SIDE_PADDING * 0.75, 0),
                    child: AppLogo(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    SIDE_PADDING * 0.75, 0, SIDE_PADDING * 0.75, TOP_PADDING),
                child: DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: WHITE_01.withOpacity(0.9)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('With Habyte, I have redeemed'),
                      Flexible(
                        child: AutoSizeText(
                          // TODO: wp - link reward name
                          'Ahh... WP, remember to change ahh. tq boss.',
                          maxLines: 5,
                          minFontSize: 6,
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: WHITE_01,
                          ),
                        ),
                      ),
                      // TODO: wp - link reward points
                      const Text('by completing ${69}\nconsecutive habits.')
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
