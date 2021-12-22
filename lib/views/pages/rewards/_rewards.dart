import 'package:flutter/material.dart';

import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/rewards/reward_list.dart';
import 'package:habyte/views/widgets/profile_score_card.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Following 'Material' prevent ListTile Ink bleeds to
    // other pages of indexedStack. Remove to try it out
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: TOP_PADDING, width: double.infinity),
          ProfileScoreCard(),
          // TODO: J - Rewards subheader?
          const RewardList(),
        ],
      ),
    );
  }
}