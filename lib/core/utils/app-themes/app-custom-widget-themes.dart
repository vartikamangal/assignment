import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../color-pallete.dart';

class CustomWidgetThemes {
  static SliderThemeData sliderTheme = SliderThemeData(
    showValueIndicator: ShowValueIndicator.always,
    trackShape: const RectangularSliderTrackShape(),
    trackHeight: 2.0,
    activeTickMarkColor: Colors.transparent,
    inactiveTickMarkColor: greyDarkShade,
    inactiveTrackColor: Colors.transparent,
    thumbColor: blueDarkShade,
    thumbShape: RoundSliderThumbShape(
      enabledThumbRadius: ScaleManager.spaceScale(
        spaceing: 12.0,
      ).value,
    ),
    overlayShape: RoundSliderOverlayShape(
      overlayRadius: ScaleManager.spaceScale(
        spaceing: 15.0,
      ).value,
    ),
  );
}
