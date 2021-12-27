import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DoubleValueListenableBuilder<A, B> extends StatelessWidget {
  const DoubleValueListenableBuilder({
    Key? key,
    required this.firstValueListenable,
    required this.secondValueListenable,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<A> firstValueListenable;
  final ValueListenable<B> secondValueListenable;
  final Widget? child;
  final Widget Function(BuildContext context, A a, B b) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: firstValueListenable,
      builder: (_, a, __) {
        return ValueListenableBuilder<B>(
          valueListenable: secondValueListenable,
          builder: (context, b, __) {
            return builder(context, a, b);
          },
        );
      },
    );
  }
}
