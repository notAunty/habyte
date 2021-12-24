import 'package:flutter/material.dart';

import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/rewards/reward_list.dart';
import 'package:habyte/views/pages/rewards/reward_list_redeemed.dart';
import 'package:habyte/views/widgets/profile_score_card.dart';
import 'package:habyte/views/widgets/share_reward_card.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: TOP_PADDING, width: double.infinity),
        ProfileScoreCard(),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Theme.of(context).colorScheme.onPrimary,
                  unselectedLabelColor: Theme.of(context)
                      .colorScheme
                      .onPrimary
                      .withOpacity(0.5),
                  tabs: const [
                    Tab(text: 'Available rewards'),
                    Tab(text: 'Redeemed rewards'),
                  ],
                ),
                Expanded(
                  // Following 'Material' prevent ListTile Ink bleeds to
                  // other pages of indexedStack. Remove to try it out
                  child: Material(
                    color: Theme.of(context).colorScheme.background,
                    child: const TabBarView(
                      children: [
                        RewardList(),
                        RewardListRedeemed(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
