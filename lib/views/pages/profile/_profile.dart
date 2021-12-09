import 'package:flutter/material.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/profile_picture.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        SizedBox(height: TOP_PADDING, width: double.infinity),
        ProfilePictureHolder(
          radius: 64,
          initials: 'JD',
          editable: true,
        ),
      ],
    );
  }
}
