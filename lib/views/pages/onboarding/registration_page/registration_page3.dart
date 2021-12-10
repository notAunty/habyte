import 'package:flutter/material.dart';

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
          const SizedBox(height: 8),
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