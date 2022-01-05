import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/viewmodels/user.dart';

import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/profile/profile_about.dart';
import 'package:habyte/views/pages/profile/profile_header.dart';
import 'package:habyte/views/pages/profile/profile_settings.dart';
import 'package:habyte/views/widgets/profile_picture.dart';
import 'package:habyte/views/pages/profile/profile_edit.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final UserVM _userVM = UserVM.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SIDE_PADDING, vertical: TOP_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const ProfileHeader(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const ProfilePictureHolder(radius: 64),
                    const SizedBox(height: TOP_PADDING),
                    Text(
                      "${_userVM.retrieveUser()!.firstName} ${_userVM.retrieveUser()!.lastName}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                const SizedBox(height: TOP_PADDING),
                const ProfileAbout(),
                const SizedBox(height: TOP_PADDING),
                const ProfileSettings(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
