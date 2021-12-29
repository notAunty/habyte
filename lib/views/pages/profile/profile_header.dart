import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/settings/_settings.dart';
import 'package:habyte/views/widgets/custom_icon_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SIDE_PADDING),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Opacity(
            opacity: 0.7,
            child: CustomIconButton(
              icon: const Icon(FeatherIcons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
