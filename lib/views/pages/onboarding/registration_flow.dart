import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/pages/main_layout.dart';
import 'package:habyte/views/widgets/profile_picture.dart';
import 'package:habyte/views/widgets/text_fields.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegistationFlow extends StatefulWidget {
  RegistationFlow({Key? key}) : super(key: key);

  @override
  State<RegistationFlow> createState() => _RegistationFlowState();
}

class _RegistationFlowState extends State<RegistationFlow> {
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
      RegistationPage3(),
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
                  physics: NeverScrollableScrollPhysics(),
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

class RegistationPage1 extends StatelessWidget {
  const RegistationPage1({Key? key, required this.formKey}) : super(key: key);

  final GlobalKey formKey;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              Text(
                'But first, let us know more about you.',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(height: 24),
              CustomTextFieldLabel(
                label: 'Name',
                child: CustomTextField(
                  maxWords: -1,
                  isRequired: true,
                  controller: nameController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistationPage2 extends StatelessWidget {
  const RegistationPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
          Text(
            'Hi there!',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(height: 8),
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
              initials: 'JD',
              editable: true,
              radius: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class RegistationPage3 extends StatelessWidget {
  const RegistationPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
          Text(
            "You're all set!",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(height: 8),
          Text(
            'You can start organizing your goals in the tasks page.',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  height: 1.25,
                  fontWeight: FontWeight.w200,
                ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Image.asset('assets/registration/3.png'),
        ],
      ),
    );
  }
}
