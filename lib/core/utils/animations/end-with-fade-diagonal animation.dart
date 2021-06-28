// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:simple_animations/simple_animations.dart';

enum AniProps { opacity, translateX, translateY }

class FadedDiagonalEndAnimation extends StatelessWidget {
  final double delay;
  final double opacity;
  final Widget child;
  final double xOffset;
  final double yOffset;
  final int duration;

  const FadedDiagonalEndAnimation(
    this.delay,
    this.child,
    this.duration,
    this.opacity,
    this.xOffset,
    this.yOffset,
  );

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(
        AniProps.opacity,
        Tween(begin: 0.50, end: opacity),
        const Duration(milliseconds: 600),
      )
      ..add(
        AniProps.translateX,
        Tween(begin: xOffset, end: 0.0),
        Duration(milliseconds: duration),
        Curves.easeOut,
      )
      ..add(
        AniProps.translateY,
        Tween(begin: yOffset, end: 0.0),
        Duration(milliseconds: duration),
        Curves.easeOut,
      );

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(
              value.get(AniProps.translateX),
              value.get(AniProps.translateY),
            ),
            child: child),
      ),
      child: child,
    );
  }
}
