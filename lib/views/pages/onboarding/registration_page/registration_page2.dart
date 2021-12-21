import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/widgets/profile_picture.dart';

class RegistationPage2 extends StatelessWidget {
  RegistationPage2({Key? key}) : super(key: key);

  final UserVM _userVM = UserVM.getInstance();

  @override
  Widget build(BuildContext context) {
    final String _userName = _userVM.retrieveTempUserJson()[USER_NAME];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
          Text(
            'Hi there, $_userName!',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Would you like to add a picture of yours so that we can know you better?',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  height: 1.25,
                  fontWeight: FontWeight.w200,
                ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Align(
            alignment: Alignment.center,
            child: ProfilePictureHolder(
              editable: true,
              isRegistering: true,
              radius: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
