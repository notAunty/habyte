import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/viewmodels/user.dart';

import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/profile/profile_header.dart';
import 'package:habyte/views/widgets/profile_picture.dart';
import 'package:habyte/views/pages/profile/profile_edit.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final UserVM _userVM = UserVM.getInstance();

  @override
  Widget build(BuildContext context) {
    final String _userFirstName = _userVM.retrieveUser()!.firstName;
    final String _userLastName = _userVM.retrieveUser()!.lastName;
    final String about = _userVM.retrieveUser()!.about ?? '';

    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: TOP_PADDING, width: double.infinity),
            const ProfileHeader(),
            const SizedBox(height: TOP_PADDING, width: double.infinity),
            Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                const ProfilePictureHolder(radius: 64),
                const SizedBox(height: TOP_PADDING),
                Text(
                  '$_userFirstName $_userLastName',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            const SizedBox(height: TOP_PADDING),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                child: ElevatedButton(
                  child: const Text('Edit Profile'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfilePage()),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: TOP_PADDING),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SIDE_PADDING),
              child: Column(
                children: [
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.overline,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    about,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
