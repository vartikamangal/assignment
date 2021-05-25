import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class DiagonalAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const DiagonalAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track('opacity')
          .add(const Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track('translateX').add(
          const Duration(milliseconds: 500), Tween(begin: 150.0, end: 0.0),
          curve: Curves.easeOut),
      Track('translateY').add(
          const Duration(milliseconds: 500), Tween(begin: 200.0, end: 0.0),
          curve: Curves.easeOut)
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation['opacity'] as double,
        child: Transform.translate(
          offset: Offset(animation['translateX'] as double, animation['translateY'] as double),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
