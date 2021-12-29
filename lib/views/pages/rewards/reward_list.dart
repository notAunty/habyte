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
              Navigator.of(context).pop();
              if (_rewardVM.redeemReward(rewardId)) {
                initiateShareCard(context,
                    shareWidget: ShareRewardCard(
                      rewardId: rewardId,
                    ));
              } else {
                print("User point is not enough");
                //TODO: Change to Snackbar
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Redeem Unsuccessful"),
                    content: const Text("Point is not enough"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      )
                    ],
                  ),
                );
              }
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
              itemBuilder: (context, index) {
                // Reverse it, view from the latest to the oldest
                Map<String, dynamic> currentReward =
                    availableRewardlist[availableRewardlist.length - 1 - index];
                return RewardItem(
                  name: currentReward[REWARD_NAME],
                  points: currentReward[REWARD_POINTS],
                  onTap: () => onTapReward(
                    context,
                    currentReward[REWARD_ID],
                    currentReward[REWARD_NAME],
                    currentReward[REWARD_POINTS],
                  ),
                  onEdit: () => onEditReward(
                    context,
                    currentReward[REWARD_ID],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
