import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/views/constant/sizes.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SIDE_PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Opacity(
            opacity: 0.7,
            child: IconButton(
              icon: const Icon(FeatherIcons.share),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
