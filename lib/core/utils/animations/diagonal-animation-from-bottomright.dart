// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';

class DiagonalAnimation extends StatelessWidget {
  final double delay;
  final double opacity;
  final Widget child;
  final double xOffset;
  final double yOffset;
  final int duration;

  const DiagonalAnimation(this.delay, this.child,this.opacity,this.xOffset,this.yOffset,this.duration);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track('opacity')
          .add(const Duration(milliseconds: 200), Tween(begin: 0.0, end: opacity)),
      Track('translateX').add(
           Duration(milliseconds: duration), Tween(begin: xOffset, end: 0.0),
          curve: Curves.easeOut),
      Track('translateY').add(
           Duration(milliseconds: duration), Tween(begin: yOffset, end: 0.0),
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
