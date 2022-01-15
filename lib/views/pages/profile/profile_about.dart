import 'package:flutter/material.dart';
import 'package:habyte/views/constant/sizes.dart';

class ProfileAbout extends StatelessWidget {
  const ProfileAbout({Key? key, required this.about}) : super(key: key);

  final String about;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('About'.toUpperCase(), style: Theme.of(context).textTheme.overline),
        const SizedBox(height: TOP_PADDING),
        Text(about != "null" ? about : "About is currently empty"),
      ],
    );
  }
}
