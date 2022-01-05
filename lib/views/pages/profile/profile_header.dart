import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/profile/profile_edit.dart';
import 'package:habyte/views/pages/settings/_settings.dart';
import 'package:habyte/views/widgets/custom_icon_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Opacity(
          opacity: 0.7,
          child: CustomIconButton(
            icon: const Icon(FeatherIcons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
        ),
      ],
    );
  }
}
