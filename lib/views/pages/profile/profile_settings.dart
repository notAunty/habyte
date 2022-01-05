import 'package:flutter/material.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:provider/src/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:habyte/viewmodels/user.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserVM _userVM = UserVM.getInstance();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Settings', style: Theme.of(context).textTheme.overline),
        ValueListenableBuilder(
          valueListenable:
              context.read<Box>().listenable(keys: [BOX_SETTINGS_THEME]),
          builder: (context, box, _widget) {
            bool currentlyDark = context
                    .read<Box>()
                    .get(BOX_SETTINGS_THEME, defaultValue: "light") ==
                "dark";
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark Mode'),
                Switch(
                  value: currentlyDark,
                  onChanged: (newValue) {
                    if (newValue) {
                      context.read<Box>().put(BOX_SETTINGS_THEME, "dark");
                    } else {
                      context.read<Box>().put(BOX_SETTINGS_THEME, "light");
                    }
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
