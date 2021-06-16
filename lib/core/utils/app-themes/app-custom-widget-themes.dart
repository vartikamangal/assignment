// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../responsive/scale-manager.dart';
import '../color-pallete.dart';

class CustomWidgetThemes {
  static SliderThemeData sliderTheme = SliderThemeData(
    showValueIndicator: ShowValueIndicator.always,
    trackShape: const RectangularSliderTrackShape(),
    trackHeight: 2.0,
    activeTickMarkColor: greyDarkShade,
    inactiveTickMarkColor: greyDarkShade,
    activeTrackColor: Colors.white,
    inactiveTrackColor: Colors.transparent,
    thumbColor: blueDarkShade,
    thumbShape: RoundSliderThumbShape(
      enabledThumbRadius: ScaleManager.spaceScale(
        spaceing: 8.0,
      ).value,
    ),
    overlayShape: RoundSliderOverlayShape(
      overlayRadius: ScaleManager.spaceScale(
        spaceing: 15.0,
      ).value,
    ),
  );
}