import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/constant/constants.dart';

Color getCardColorByScores(int scores) {
  String membershipTierByScores = getMembershipTierByScores(scores);
  int membershipTierIndex = MEMBERSHIP_TIER.indexOf(membershipTierByScores);
  return MEMBERSHIP_COLOR[membershipTierIndex];
}

String getMembershipTierByScores(int scores) {
  String membershipTierByScores = MEMBERSHIP_TIER_MIN_SCORE.keys
      .lastWhere((key) => MEMBERSHIP_TIER_MIN_SCORE[key]! <= scores);
  return membershipTierByScores;
}
