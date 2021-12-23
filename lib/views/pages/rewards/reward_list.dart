import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/rewards/reward_edit.dart';
import 'package:habyte/views/pages/rewards/reward_item.dart';

class RewardList extends StatefulWidget {
  const RewardList({Key? key}) : super(key: key);

  @override
  State<RewardList> createState() => _RewardListState();
}

class _RewardListState extends State<RewardList> {
  // Mock
  final List<int> rewardPoint = [5, 10, 15, 20, 25, 30, 5, 5, 5, 10];

  final List<String> rewardName = [
    "Have a cheat meal at MCDonald's",
    "Have a cheat meal at MCDonald's",
    "Have a cheat meal at MCDonald's",
    "Have a cheat meal at MCDonald's",
    "Have a cheat meal at MCDonald's",
    "Have a cheat meal at MCDonald's",
    "Have a cheat meal at MCDonald's",
    "Have a cheat meal at MCDonald's",
    "Have a cheat meal at MCDonald's",
    "Visit an Art Exhibition"
  ];

  void onEditRewards(context, String rewardId) {
    showDialog(
      context: context,
      builder: (context) => RewardEdit(
        isUpdate: true,
        rewardId: rewardId,
      ),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: TOP_PADDING * 3),
        child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: rewardPoint.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8.0),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: SIDE_PADDING,
          ),
          itemBuilder: (context, index) => RewardItem(
            name: rewardName[index],
            points: rewardPoint[index],
            onTap: () {
              print('bb');
            },
            onEdit: () => onEditRewards(context, index.toString()),
          ),
        ),
      ),
    );
  }
}
