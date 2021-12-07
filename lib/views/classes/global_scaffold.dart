import 'package:flutter/material.dart';

class GlobalScaffold {
  GlobalScaffold(BuildContext c) {
    // _context = c;
  }

  // late BuildContext _context;
  final GlobalKey<ScaffoldMessengerState> key = GlobalKey();

  void showDefaultSnackbar({String message = ""}) =>
    key.currentState!.showSnackBar(SnackBar(content: Text(message)));
}
