// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';

class SlideRouteNegativeYAxisAnimation extends MaterialPageRoute {
  SlideRouteNegativeYAxisAnimation(
      {WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final custom = MultiTrackTween([
      Track('opacity')
          .add(const Duration(milliseconds: 100), Tween(begin: 1.0, end: 1.0)),
      Track('translateY').add(
          const Duration(milliseconds: 400), Tween(begin: -Get.height*0.80, end: 0),
          curve: Curves.easeOut)
    ]);
    return ControlledAnimation(
        duration: custom.duration,
        tween: custom,
        builderWithChild: (context, child, animation) => Opacity(
              opacity: (animation['opacity'] as num).toDouble(),
              child: Transform.translate(
                offset: Offset(0, animation['translateY'] as double),
                child: child,
              ),
            ),
        child: child);
  }
}
