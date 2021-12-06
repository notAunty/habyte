import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:habyte/views/classes/global_scaffold.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        onPressed: () {
          context.read<GlobalScaffold>().showDefaultSnackbar(message: 'This is a default snackbar.');
        },
      ),
    );
  }
}
