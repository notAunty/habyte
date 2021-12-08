import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/pages/main_layout.dart';
import 'package:habyte/views/pages/onboarding/registration_flow.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingnFlow extends StatefulWidget {
  const OnboardingnFlow({Key? key}) : super(key: key);

  @override
  State<OnboardingnFlow> createState() => _OnboardingnFlowState();
}

class _OnboardingnFlowState extends State<OnboardingnFlow> {
  late PageController _pageController;
  double _currentPage = 0.0;
  bool _isLastPage = false;

  final List<Widget> onboardingPages = [
    const OnboardingnPage1(),
    const OnboardingnPage2(),
    const OnboardingnPage3(),
  ];

  void next() => animateScroll(_currentPage.round() + 1);
  void previous() => animateScroll(_currentPage.round() - 1);
  void done() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegistationFlow()),
      );
  Future<void> animateScroll(int page) async {
    await _pageController.animateToPage(
      max(min(page, onboardingPages.length - 1), 0),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  void onPageChanged(int page) {
    if (page == onboardingPages.length - 1) {
      setState(() {
        _isLastPage = true;
      });
    } else {
      setState(() {
        _isLastPage = false;
      });
    }
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
                  children: onboardingPages,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: onPageChanged,
                  physics: const BouncingScrollPhysics(),
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
              count: onboardingPages.length,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: ElevatedButton.icon(
                icon:
                    Text(_isLastPage ? "I'm ready. Let's do this!" : 'Next'),
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
                onPressed: _isLastPage ? done : next,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class OnboardingnPage1 extends StatelessWidget {
  const OnboardingnPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Keep track of your habits all in one place.',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          Image.asset('assets/onboarding/1.png'),
        ],
      ),
    );
  }
}

class OnboardingnPage2 extends StatelessWidget {
  const OnboardingnPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset('assets/onboarding/2.png'),
          Text(
            'Set your own goal and redeem rewards as you accomplish them.',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class OnboardingnPage3 extends StatelessWidget {
  const OnboardingnPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'The best time to start is now.',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'A journey of a thousand miles begins with a single step. Are you ready to kickstart your journey to become better?',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      height: 1.25,
                      fontWeight: FontWeight.w200,
                    ),
              ),
            ],
          ),
          Image.asset('assets/onboarding/3.png'),
        ],
      ),
    );
  }
}
