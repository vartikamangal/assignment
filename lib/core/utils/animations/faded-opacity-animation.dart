import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class FadedOpacityAnimation extends StatelessWidget {
  final Duration duration;
  final Widget child;

  const FadedOpacityAnimation({
    Key key,
    this.duration = const Duration(milliseconds: 600),
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Animator<double>(
      tween: Tween<double>(begin: 0.5, end: 1),
      duration: duration,
      builder: (context, animatorState, child) => FadeTransition(
        opacity: AlwaysStoppedAnimation<double>(animatorState.value),
        child: child,
      ),
    );
  }
}
