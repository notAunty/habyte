import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habyte/views/pages/main_layout.dart';

void onAddRewardsPressed(BuildContext context) {
  // TODO: change push to add rewards page
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const MainLayout()));
}
