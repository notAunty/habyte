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
    return Scaffold(
      body: SafeArea(
        child: StatefulBuilder(
          builder: (context, setState) {
            final String _userFirstName = _userVM.retrieveUser()!.firstName;
            final String _userLastName = _userVM.retrieveUser()!.lastName;
            final String _userName = _userFirstName + ' ' + _userLastName;
            final String about = _userVM.retrieveUser()!.about ?? '';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: TOP_PADDING, width: double.infinity),
                const ProfileHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SIDE_PADDING),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const ProfilePictureHolder(radius: 64),
                      const SizedBox(height: TOP_PADDING),
                      Text(
                        _userName,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
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
                              builder: (context) => EditProfilePage(
                                    setState: setState,
                                  )),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: TOP_PADDING),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SIDE_PADDING),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('About',
                          style: Theme.of(context).textTheme.overline),
                      const SizedBox(height: 8),
                      Text(about, style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
