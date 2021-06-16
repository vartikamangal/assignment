// Flutter imports:
import 'package:flutter/foundation.dart';

String getSliderEmotion({
  @required double value,
  @required double lowerLimit,
  @required double upperLimit,
}) {
  // For getting mean of emotion-values
  final middlePoint = (upperLimit + lowerLimit) / 2;

  // Condition for showing different emojis
  final bool userVeryHappy = value == upperLimit;
  final bool userVerySad = value == lowerLimit;
  final bool userIsNeutral = value == middlePoint;
  final bool userSomewhatSad = value < middlePoint && value > lowerLimit;
  final bool userSomewhatHappy = value > middlePoint && value < upperLimit;

  // Driver code
  if (userVeryHappy) {
    return 'assets/Rapport_light_image/very_good.png';
  } else if (userVerySad) {
    return 'assets/Rapport_light_image/very_bad.png';
  } else if (userSomewhatSad) {
    return 'assets/Rapport_light_image/bad.png';
  } else if (userSomewhatHappy) {
    return 'assets/Rapport_light_image/good.png';
  } else if (userIsNeutral) {
    return 'assets/Rapport_light_image/neutral.png';
  } else {
    // No-usable consition, Just here coz. of Dart VM.
    return 'assets/Rapport_light_image/neutral.png';
  }
}
