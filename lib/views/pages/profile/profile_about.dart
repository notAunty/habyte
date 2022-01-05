import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/user.dart';

class ProfileAbout extends StatelessWidget {
  const ProfileAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserVM _userVM = UserVM.getInstance();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('About'.toUpperCase(), style: Theme.of(context).textTheme.overline),
        const SizedBox(height: 8),
        Text(_userVM.retrieveUser()!.about ?? '',
            style: Theme.of(context).textTheme.bodyText2),
      ],
    );
  }
}
