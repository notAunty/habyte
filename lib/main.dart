import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:habyte/models/entry.dart';
import 'package:habyte/models/notification.dart';
import 'package:habyte/models/reward.dart';
import 'package:habyte/models/task.dart';
import 'package:habyte/utils/theme_mode.dart';

import 'package:habyte/views/constant/themes.dart';
import 'package:habyte/views/pages/main_layout.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/classes/global_scaffold.dart';
import 'package:habyte/views/pages/onboarding/onboarding_flow.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(RewardAdapter());
  Hive.registerAdapter(NotificationDetailAdapter());
  Hive.registerAdapter(EntryModelAdapter());

  await Hive.openBox(BOX_NAME);
  await Hive.openBox<Task>(BOX_TASK);
  await Hive.openBox<Reward>(BOX_REWARD);
  await Hive.openBox<NotificationDetail>(BOX_NOTIFICATION_DETAIL);
  await Hive.openBox<EntryModel>(BOX_ENTRY);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Box>(
          create: (_) => Hive.box(BOX_NAME),
        ),
        Provider<GlobalScaffold>(
          create: (context) => GlobalScaffold(context),
        )
      ],
      child: Builder(
        builder: (context) {
          return ValueListenableBuilder(
            valueListenable:
                context.read<Box>().listenable(keys: [BOX_SETTINGS_THEME]),
            builder: (context, box, _widget) {
              return MaterialApp(
                title: 'Habyte',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeModeFromString(
                  context.read<Box>().get(BOX_SETTINGS_THEME, defaultValue: ""),
                ),
                scaffoldMessengerKey: context.read<GlobalScaffold>().key,
                home: const MainLayout(),
              );
            },
          );
        },
      ),
    );
  }
}
