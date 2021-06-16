// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animations/animations.dart';

class CustomHero extends StatelessWidget {
  /// Which widget you are clicking onto
  final Widget from;

  /// Which widget you want to goto
  final Widget to;

  const CustomHero({
    Key key,
    @required this.from,
    @required this.to,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(
        milliseconds: 400,
      ),
      closedElevation: 0,
      closedBuilder: (context, child) => from,
      openBuilder: (context, child) => to,
      tappable: true,
      transitionType: ContainerTransitionType.fade,
    );
  }
}
