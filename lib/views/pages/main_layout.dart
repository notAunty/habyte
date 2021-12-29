import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/widgets/animated_indexed_stack.dart';

import 'package:habyte/views/pages/dashboard/_dashboard.dart';
import 'package:habyte/views/pages/profile/_profile.dart';
import 'package:habyte/views/pages/rewards/_rewards.dart';
import 'package:habyte/views/pages/rewards/add_rewards.dart';
import 'package:habyte/views/pages/tasks/_tasks.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  final List<GButton> _bottomNavItems = [
    const GButton(
      text: 'Home',
      icon: FeatherIcons.home,
    ),
    const GButton(
      text: 'Tasks',
      icon: FeatherIcons.checkCircle,
    ),
    const GButton(
      text: 'Rewards',
      icon: FeatherIcons.award,
    ),
    const GButton(
      text: 'Profile',
      icon: FeatherIcons.user,
    ),
  ];
  final List<Widget> _pages = [
    DashboardPage(),
    TasksPage(),
    RewardsPage(),
    ProfilePage(),
  ];
  late List<void Function(BuildContext)?> _onFabClicked;

  @override
  Widget build(BuildContext context) {
    _onFabClicked = [
      null,
      null, // TODO: add task onClicked goes here
      onAddRewardsPressed,
      null,
    ];

    return Scaffold(
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.all(8),
        child: GNav(
          gap: 4,
          tabBorderRadius: 99,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          activeColor: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          tabActiveBorder: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
          tabs: _bottomNavItems,
          selectedIndex: _selectedIndex,
          onTabChange: (newIndex) => setState(() {
            _selectedIndex = newIndex;
          }),
        ),
      ),
      floatingActionButton: (_onFabClicked[_selectedIndex] != null)
          ? FloatingActionButton(
              heroTag: Random.secure().nextDouble(),
              child: const Icon(FeatherIcons.plus, color: WHITE_01),
              onPressed: () => _onFabClicked[_selectedIndex]!(context),
            )
          : null,
      body: SafeArea(
        child: AnimatedIndexedStack(index: _selectedIndex, children: _pages),
      ),
    );
  }
}
