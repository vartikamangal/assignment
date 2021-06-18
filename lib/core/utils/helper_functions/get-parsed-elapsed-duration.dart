import 'dart:developer';

/// For getting the elapsed recording duration in proper format as per Figma design
String getElapsedDuration(Duration duration) {
  final ifMinuteIsSingleDigit =
      duration.inMinutes >= 0 || duration.inMinutes < 10;
  final ifSecondIsSingleDigit =
      duration.inSeconds >= 0 || duration.inSeconds < 10;
  log(duration.inMinutes.toString());
  log(duration.inSeconds.toString());
  if (ifMinuteIsSingleDigit && ifSecondIsSingleDigit) {
    log('a');
    return "0${duration.inMinutes}:0${duration.inSeconds}";
  } else if (ifMinuteIsSingleDigit) {
    log('b');
    return "0${duration.inMinutes}:${duration.inSeconds}";
  } else if (ifSecondIsSingleDigit) {
    log('c');
    return "${duration.inMinutes}:0${duration.inSeconds}";
  } else {
    log('d');
    return "${duration.inMinutes}:${duration.inSeconds}";
  }
}
