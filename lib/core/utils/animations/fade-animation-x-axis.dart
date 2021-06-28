// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:simple_animations/simple_animations.dart';

enum AniProps { opacity, translateX }

class FadeAnimationXAxis extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimationXAxis(
    this.delay,
    this.child,
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final tween = MultiTween<AniProps>()
      ..add(
        AniProps.opacity,
        Tween(begin: 0.0, end: 1.0),
        const Duration(milliseconds: 100),
      )
      ..add(
        AniProps.translateX,
        Tween(begin: width * 0.90, end: 0.0),
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
            offset: Offset(value.get(AniProps.translateX),0), child: child),
      ),
      child: child,
    );
  }
}
