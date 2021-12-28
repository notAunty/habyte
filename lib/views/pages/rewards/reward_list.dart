import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/viewmodels/reward.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/rewards/reward_edit.dart';
import 'package:habyte/views/pages/rewards/reward_item.dart';
import 'package:habyte/views/pages/share/initiate_share_card.dart';
import 'package:habyte/views/widgets/share_reward_card.dart';

class RewardList extends StatefulWidget {
  const RewardList({Key? key}) : super(key: key);

  @override
  State<RewardList> createState() => _RewardListState();
}

class _RewardListState extends State<RewardList> {
  final RewardVM _rewardVM = RewardVM.getInstance();
  final Notifiers _notifiers = Notifiers.getInstance();

  void onEditReward(context, String rewardId) {
    showDialog(
      context: context,
      builder: (context) => RewardEdit(
        isUpdate: true,
        rewardId: rewardId,
      ),
    ).then((_) => setState(() {}));
  }

  void onTapReward(context, String rewardId, String name, int point) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Redeem this reward?'),
        content: Text(
          '$name ($point points)',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _rewardVM.redeemReward(rewardId);
              Navigator.of(context).pop();
              initiateShareCard(context,
                  shareWidget: ShareRewardCard(
                    rewardId: rewardId,
                  ));
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: TOP_PADDING * 3),
        child: ValueListenableBuilder<Object>(
          valueListenable: _notifiers.getAvailableRewardsNotifier(),
          builder: (context, availableRewardlist, _) {
            return ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount:
                  (availableRewardlist as List<Map<String, dynamic>>).length,
              separatorBuilder: (context, index) => const SizedBox(height: 8.0),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: SIDE_PADDING,
              ),
              itemBuilder: (context, index) => RewardItem(
                name: availableRewardlist[index][REWARD_NAME],
                points: availableRewardlist[index][REWARD_POINTS],
                onTap: () => onTapReward(
                  context,
                  availableRewardlist[index][REWARD_ID],
                  availableRewardlist[index][REWARD_NAME],
                  availableRewardlist[index][REWARD_POINTS],
                ),
                onEdit: () => onEditReward(
                  context,
                  availableRewardlist[index][REWARD_ID],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
