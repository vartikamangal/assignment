import 'package:flutter/material.dart';

class PathChecker extends StatelessWidget {
  final String userPath;
  final Widget widgetForSmallWins;
  final Widget widgetForBigGoals;
  final bool isNewUser;

  const PathChecker({
    Key? key,
    required this.userPath,
    required this.widgetForBigGoals,
    required this.widgetForSmallWins,
    required this.isNewUser,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (userPath == 'BIG_GOALS') {
      return widgetForBigGoals;
    } else {
      return widgetForSmallWins;
    }
  }
}
