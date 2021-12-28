import 'package:flutter/material.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/widgets/profile_picture.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/pages/profile/profile_edit.dart';
import 'package:habyte/views/pages/profile/profile_preference.dart';

class Profile extends StatelessWidget {
  final UserVM _userVM = UserVM.getInstance();

  void addTempFirstName(String firstName) =>
      _userVM.addTempUserData({USER_FIRST_NAME: firstName});
  void addTempLastName(String lastName) =>
      _userVM.addTempUserData({USER_LAST_NAME: lastName});
  void addTempAbout(String about) =>
      _userVM.addTempUserData({USER_ABOUT: about});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePreference()),
                );
              },
              icon: Icon(Icons.settings),
            ),
          ],
          //title: Text('Proflie'),
        ),
        body: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: TOP_PADDING, width: double.infinity),
                const ProfilePictureHolder(
                  radius: 64,
                  editable: false,
                ),
                const SizedBox(height: TOP_PADDING),
                buildName(_userVM),
                const SizedBox(height: TOP_PADDING),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
                  child: ElevatedButton(
                    child: const Text('Edit Profile >'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      shadowColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()),
                      );
                    },
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 8),
                  buildAbout(_userVM, context),
                ]),
              ]),
        ),
      );

  Widget buildName(UserVM _userVM) {
    final String _userFirstName = _userVM.retrieveUser()!.firstName;
    final String _userLastName = _userVM.retrieveUser()!.lastName;
    return Column(
      children: [
        Text(
          '$_userFirstName $_userLastName',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ],
    );
  }

  Widget buildAbout(UserVM _userVM, context) {
    final String about = _userVM.retrieveUser()!.about ?? '';

    return Column(
      children: [
        Text(
          about,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                height: 1.25,
                fontWeight: FontWeight.w200,
              ),
        ),
      ],
    );
  }
}
