import 'package:flutter/material.dart';
import 'package:habyte/viewmodels/notifiers.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/profile/profile_about.dart';
import 'package:habyte/views/pages/profile/profile_header.dart';
import 'package:habyte/views/pages/profile/profile_reminders.dart';
import 'package:habyte/views/pages/profile/profile_settings.dart';
import 'package:habyte/views/widgets/double_value_listenable_builder.dart';
import 'package:habyte/views/widgets/profile_picture.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final Notifiers _notifiers = Notifiers.getInstance();

  @override
  Widget build(BuildContext context) {
    return DoubleValueListenableBuilder<String, String>(
      firstValueListenable: _notifiers.getNameNotifier(),
      secondValueListenable: _notifiers.getAboutNotifier(),
      builder: (context, userName, userAbout) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: SIDE_PADDING, vertical: TOP_PADDING),
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
                          userName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                    const SizedBox(height: TOP_PADDING),
                    ProfileAbout(
                      about: userAbout,
                    ),
                    const SizedBox(height: TOP_PADDING),
                    const Divider(),
                    const SizedBox(height: TOP_PADDING),
                    const ProfileSettings(),
                    const Divider(),
                    const SizedBox(height: TOP_PADDING),
                    ProfileReminders(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
