import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/rewards/reward_item.dart';
import 'package:habyte/views/pages/share/initiate_share_card.dart';
import 'package:habyte/views/widgets/share_reward_card.dart';

class RewardListRedeemed extends StatelessWidget {
  const RewardListRedeemed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Notifiers _notifiers = Notifiers.getInstance();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: TOP_PADDING * 3),
        child: ValueListenableBuilder<Object>(
          valueListenable: _notifiers.getRedeemedRewardsNotifier(),
          builder: (context, redeemedRewardlist, _) {
            return ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount:
                  (redeemedRewardlist as List<Map<String, dynamic>>).length,
              separatorBuilder: (context, index) => const SizedBox(height: 8.0),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: SIDE_PADDING,
              ),
              itemBuilder: (context, index) => RedeemedRewardItem(
                name: redeemedRewardlist[index][REWARD_NAME],
                points: redeemedRewardlist[index][REWARD_POINTS],
                onTap: () => initiateShareCard(
                  context,
                  shareWidget: ShareRewardCard(
                    rewardId: redeemedRewardlist[index][REWARD_ID],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
