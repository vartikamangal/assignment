import 'package:flutter/material.dart';

const String weekendDayCode = 'Wed';

//! not present in guided path
class WeekendWidgetInjector extends StatelessWidget {
  final String weekDay;
  final bool isNewUser;
  final bool toShowCatgories;
  final Widget widgetToShow;
  final Widget placeHolderWidget;
  final String userPath;

  const WeekendWidgetInjector({
    Key? key,
    required this.weekDay,
    required this.placeHolderWidget,
    required this.toShowCatgories,
    required this.userPath,
    required this.widgetToShow,
    required this.isNewUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //! Change RHS weekDay -> weekendDayCode for production
    if (weekDay == weekDay &&
        !isNewUser &&
        userPath == 'SMALL_WINS' &&
        toShowCatgories) {
      return widgetToShow;
    } else {
      return placeHolderWidget;
    }
  }
}
