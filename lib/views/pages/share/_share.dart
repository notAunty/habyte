import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:habyte/views/classes/global_scaffold.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/widgets/profile_score_card.dart';

void initiateShareCard(BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      opaque: false,
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => SharePage(),
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

class SharePage extends StatelessWidget {
  late Uint8List imageInMemory;

  final GlobalKey _globalKey = GlobalKey();

  Future<Uint8List?> _capturePng(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
      Uint8List pngBytes = byteData.buffer.asUint8List();
      imageInMemory = pngBytes;
      if (kDebugMode) {
        print(imageInMemory);
      }
      return pngBytes;

    } catch (e) {
      context
          .read<GlobalScaffold>()
          .showDefaultSnackbar(message: "Error generating share image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 800),
    ).then((_) {
      _capturePng(context);
    });

    return Scaffold(
      backgroundColor: BLACK_01.withOpacity(0.8),
      body: Align(
        alignment: const Alignment(0, -0.8),
        child: RepaintBoundary(
          key: _globalKey,
          child: ProfileScoreCard(),
        ),
      ),
    );
  }
}
