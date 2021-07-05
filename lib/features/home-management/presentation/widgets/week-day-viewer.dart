import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/universal-widgets/day-selector-box.dart';

class WeekDayViewerComponent extends StatelessWidget {
  const WeekDayViewerComponent({
    Key? key,
    required this.activeDay,
    required this.daysToBeShownInUI,
  }) : super(key: key);

  final List<String> daysToBeShownInUI;
  final String activeDay;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: daysToBeShownInUI
          .map(
            (day) => buildDayBox(
              day,
              // ignore: avoid_bool_literals_in_conditional_expressions
              activeDay == day ? true : false,
            ),
          )
          .toList(),
    );
  }
}
