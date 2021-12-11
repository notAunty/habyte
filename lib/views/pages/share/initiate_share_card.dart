import 'package:flutter/material.dart';
import 'package:habyte/views/pages/share/_share.dart';

void initiateShareCard(BuildContext context, {required Widget shareWidget}) {
  Navigator.push(
    context,
    PageRouteBuilder(
      opaque: false,
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => SharePage(
        child: shareWidget,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        bool reverse = animation.status == AnimationStatus.reverse;
        return SlideTransition(
          position:
              Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
                  .animate(
            CurvedAnimation(
              parent: animation,
              curve: reverse ? Curves.easeInExpo : Curves.easeOutExpo,
            ),
          ),
          child: child,
        );
      },
    ),
  );
}

