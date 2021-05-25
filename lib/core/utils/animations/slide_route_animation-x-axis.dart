import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class SlideRouteXAxisAnimation extends MaterialPageRoute{
  SlideRouteXAxisAnimation({WidgetBuilder builder, RouteSettings settings}) : super(builder: builder,settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    var custom =  MultiTrackTween([
      Track('opacity')
          .add(const Duration(milliseconds: 300), Tween(begin: 0.0, end: 1.0)),
      Track('translateX').add(
          const Duration(milliseconds: 300), Tween(begin: 100.0, end: 0.0),
          curve: Curves.easeInOut)
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
