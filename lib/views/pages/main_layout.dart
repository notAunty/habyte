import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/views/pages/dashboard/_dashboard.dart';
import 'package:habyte/views/pages/profile/_profile.dart';
import 'package:habyte/views/pages/rewards/_rewards.dart';
import 'package:habyte/views/pages/tasks/_tasks.dart';
import 'package:habyte/views/widgets/animated_indexed_stack.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  final List<BottomNavigationBarItem> _bottomNavItems = [
    const BottomNavigationBarItem(
      label: 'Dashboard',
      icon: Icon(FeatherIcons.home),
    ),
    const BottomNavigationBarItem(
      label: 'Tasks',
      icon: Icon(FeatherIcons.checkCircle),
    ),
    const BottomNavigationBarItem(
      label: 'Rewards',
      icon: Icon(FeatherIcons.award),
    ),
    const BottomNavigationBarItem(
      label: 'Profile',
      icon: Icon(FeatherIcons.user),
    ),
  ];
  final List<Widget> _pages = [
    const DashboardPage(),
    const TasksPage(),
    const RewardsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: _bottomNavItems,
        currentIndex: _selectedIndex,
        onTap: (newIndex) => setState(() {
          _selectedIndex = newIndex;
        }),
      ),
      body: AnimatedIndexedStack(index: _selectedIndex, children: _pages),
    );
  }
}
