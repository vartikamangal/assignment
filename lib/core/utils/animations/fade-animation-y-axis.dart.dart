// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:simple_animations/simple_animations.dart';

enum AniProps { opacity, translateY }

class FadeAnimationYAxis extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimationYAxis(
    this.delay,
    this.child,
  );

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(
        AniProps.opacity,
        Tween(begin: 0.0, end: 1.0),
        const Duration(milliseconds: 500),
      )
      ..add(
        AniProps.translateY,
        Tween(begin: -120.0, end: 0.0),
        const Duration(milliseconds: 300),
        Curves.easeOut,
      );

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(0, value.get(AniProps.translateY)), child: child),
      ),
      child: child,
    );
  }
}
