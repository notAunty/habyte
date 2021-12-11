import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:habyte/views/pages/share/share_header.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:habyte/views/classes/global_scaffold.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/widgets/profile_score_card.dart';

class SharePage extends StatelessWidget {
  SharePage({Key? key, required this.child}) : super(key: key);

  final Widget child;
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

  void _share(BuildContext context) async {
    Uint8List? capturedPngUint8List = await _capturePng(context);
    if (capturedPngUint8List == null) return;

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/share.png';
    File(path).writeAsBytesSync(capturedPngUint8List);
    await Share.shareFiles([path], text: 'Shared image');
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 800),
    ).then((_) {
      _share(context);
    });

    return Scaffold(
      backgroundColor: BLACK_01.withOpacity(0.5),
      body: SafeArea(
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 5.0),
            child: Column(
              children: [
                const SizedBox(height: TOP_PADDING, width: double.infinity),
                const SharePageHeader(),
                RepaintBoundary(key: _globalKey, child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
