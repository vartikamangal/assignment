// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Package imports:
import 'package:simple_animations/simple_animations.dart';

class FadeAnimationXAxis extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimationXAxis(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track('opacity')
          .add(const Duration(milliseconds: 100), Tween(begin: 1.0, end: 1.0)),
      Track('translateX').add(
          const Duration(milliseconds: 300), Tween(begin: Get.width*0.90, end: 0.0),
          curve: Curves.easeOut)
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation['opacity'] as double,
        child: Transform.translate(
          offset: Offset(animation['translateX'] as double, 0),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
