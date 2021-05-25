import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';
import '../color-pallete.dart';

Widget daySelector(String day) {
  final textScaleFactor = ScaleManager.textScale.value;
  return Container(
    height: ScaleManager.spaceScale(spaceing: 27).value,
    width: ScaleManager.spaceScale(spaceing: 45).value,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft:
                Radius.circular(ScaleManager.spaceScale(spaceing: 24).value),
            bottomRight:
                Radius.circular(ScaleManager.spaceScale(spaceing: 24).value),
            topRight:
                Radius.circular(ScaleManager.spaceScale(spaceing: 24).value),
            bottomLeft:
                Radius.circular(ScaleManager.spaceScale(spaceing: 24).value)),
        border: Border.all(color: greyDayBox)),
    child: Container(
      margin: EdgeInsets.only(top: ScaleManager.spaceScale(spaceing: 4).value),
      child: Text(
        '$day',
        textAlign: TextAlign.center,
        style: AppTextStyle.dayText,
        textScaleFactor: textScaleFactor,
      ),
    ),
  );
}
