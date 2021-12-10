import 'package:flutter/material.dart';

import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/profile_score_card.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: TOP_PADDING, width: double.infinity),
        ProfileScoreCard(),
      ],
    );
  }
}