import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/rewards/reward_item.dart';
import 'package:habyte/views/pages/rewards/reward_redeemed.dart';

class RewardList extends StatelessWidget {
  const RewardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock
    final List<int> rewardPoint = [5, 10];

    final List<String> rewardName = [
      "Have a cheat meal at MCDonald's",
      "Visit an Art Exhibition"
    ];
    return StatefulBuilder(
      builder: (context, setState) => ListView.separated(
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: SIDE_PADDING,
        ),
        itemCount: rewardPoint.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) => RewardRedeemed(
          points: rewardPoint[index],
          name: rewardName[index],
        ),
      ),
    );
  }
}
