import 'package:flutter/material.dart';

class ProfileAbout extends StatelessWidget {
  const ProfileAbout({Key? key, required this.about}) : super(key: key);

  final String about;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('About'.toUpperCase(), style: Theme.of(context).textTheme.overline),
        const SizedBox(height: 8),
        Text(about, style: Theme.of(context).textTheme.bodyText2),
      ],
    );
  }
}
