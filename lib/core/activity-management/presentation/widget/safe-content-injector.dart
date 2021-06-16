import 'package:flutter/material.dart';

/// This is useful in scnearios where the user hasn't chosen any path yet, But wants to
/// start a quick activity,
/// The error persisted in this scenario was due to the changes in varNames in response
/// of SMALL_WINS and BIG_GOALS getRecommendationActivities part
/// So currently it will help in determining wheater user has chosen a path or not

class SafeContentInjector extends StatelessWidget {
  final String userPath;
  final Widget ifNullPathWidget;
  final Widget ifChosenPathSmallWins;
  final Widget ifChosenPathBigGoals;

  const SafeContentInjector({
    Key key,
    @required this.ifChosenPathSmallWins,
    @required this.ifChosenPathBigGoals,
    @required this.ifNullPathWidget,
    @required this.userPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userPath == null) {
      return ifNullPathWidget;
    } else {
      if (userPath == 'SMALL_WINS') {
        return ifChosenPathSmallWins;
      } else {
        return ifChosenPathBigGoals;
      }
    }
  }
}
