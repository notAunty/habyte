import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habyte/views/pages/main_layout.dart';
import 'package:habyte/views/pages/rewards/reward_edit.dart';

void onAddRewardsPressed(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => RewardEdit(
      isUpdate: false,
    ),
  );
}
