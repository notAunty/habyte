import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/viewmodels/user.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/pages/main_layout.dart';
import 'package:habyte/views/pages/onboarding/registration_page/registration_page1.dart';
import 'package:habyte/views/pages/onboarding/registration_page/registration_page2.dart';
import 'package:habyte/views/pages/onboarding/registration_page/registration_page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegistationFlow extends StatefulWidget {
  const RegistationFlow({Key? key}) : super(key: key);

  @override
  State<RegistationFlow> createState() => _RegistationFlowState();
}

class _RegistationFlowState extends State<RegistationFlow> {
  final UserVM _userVM = UserVM.getInstance();
  late PageController _pageController;
  double _currentPage = 0.0;
  bool _isLastPage = false;

  late List<Widget> registrationPages;
  late List<GlobalKey<FormState>> formKeys;

  Future<void> animateScroll(int page) async {
    await _pageController.animateToPage(
      max(min(page, registrationPages.length - 1), 0),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  void onPageChanged() {
    int toPage = _currentPage.round() + 1;
    if (toPage >= registrationPages.length) {
      _userVM.createUser();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainLayout()),
      );
      return;
    } else {
      for (GlobalKey<FormState> formKey in formKeys) {
        if (!(formKey.currentState?.validate() ?? true)) return;
      }
      if (toPage == registrationPages.length - 1) {
        setState(() {
          _isLastPage = true;
        });
      } else {
        setState(() {
          _isLastPage = false;
        });
      }
    }
    FocusScope.of(context).unfocus();
    animateScroll(toPage);
  }

  bool _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics is PageMetrics && metrics.page != null) {
      if (mounted) {
        setState(() => _currentPage = metrics.page!);
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    formKeys = [GlobalKey<FormState>()];
    registrationPages = [
      RegistationPage1(formKey: formKeys[0]),
      RegistationPage2(),
      const RegistationPage3(),
    ];
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: _onScroll,
                child: PageView(
                  controller: _pageController,
                  children: registrationPages,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ),
            SmoothPageIndicator(
              effect: WormEffect(
                dotWidth: 8,
                dotHeight: 8,
                activeDotColor: GREY_02,
                dotColor: GREY_02.withOpacity(0.5),
              ),
              controller: _pageController,
              count: registrationPages.length,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: ElevatedButton.icon(
                icon: Text(_isLastPage ? "Let's go!" : 'Next'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                label: _isLastPage
                    ? const SizedBox(width: 0)
                    : const Icon(FeatherIcons.arrowRight, size: 16),
                onPressed: onPageChanged,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
