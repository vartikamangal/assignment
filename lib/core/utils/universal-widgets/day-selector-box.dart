// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';
import '../color-pallete.dart';

// ignore: avoid_positional_boolean_parameters
Widget buildDayBox(String day, bool isActiveDay) {
  final textScaleFactor = ScaleManager.textScale.value;
  return Container(
    height: ScaleManager.spaceScale(
      spaceing: 27,
    ).value,
    width: ScaleManager.spaceScale(
      spaceing: 45,
    ).value,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(
          ScaleManager.spaceScale(
            spaceing: 24,
          ).value,
        ),
        bottomRight: Radius.circular(
          ScaleManager.spaceScale(
            spaceing: 24,
          ).value,
        ),
        topRight: Radius.circular(
          ScaleManager.spaceScale(
            spaceing: 24,
          ).value,
        ),
        bottomLeft: Radius.circular(
          ScaleManager.spaceScale(
            spaceing: 24,
          ).value,
        ),
      ),
      color: isActiveDay ? blueLightShade : Get.theme.canvasColor,
      border: Border.all(
        color: greyDayBox,
      ),
    ),
    child: Center(
      child: Text(
        day[0],
        textAlign: TextAlign.center,
        style: isActiveDay
            ? AppTextStyle.dayText.copyWith(
                color: blueDarkerShade,
                fontWeight: FontWeight.w700,
              )
            : AppTextStyle.dayText,
        textScaleFactor: textScaleFactor,
      ),
    ),
  );
}
