// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:simple_animations/simple_animations.dart';

class SlideRouteXAxisAnimation extends MaterialPageRoute {
  SlideRouteXAxisAnimation({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var custom = MultiTrackTween([
      Track('opacity')
          .add(const Duration(milliseconds: 400), Tween(begin: 1.0, end: 1.0)),
      Track('translateX').add(const Duration(milliseconds: 400),
          Tween(begin: Get.width * 0.8, end: 0.0),
          curve: Curves.easeOut)
    ]);
    return ControlledAnimation(
        duration: custom.duration,
        tween: custom,
        builderWithChild: (context, child, animation) => Opacity(
              opacity: animation['opacity'] as double,
              child: Transform.translate(
                offset: Offset(animation['translateX'] as double, 0),
                child: child,
              ),
            ),
        child: child);
  }
}
