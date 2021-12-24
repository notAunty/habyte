import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12,
      child: Row(
        children: [
          Image.asset('assets/logo/white.png'),
          const SizedBox(width: 2),
          Text(
            'Habyte',
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: WHITE_01),
          ),
        ],
      ),
    );
  }
}
