// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../color-pallete.dart';

class AppThemes {
  final ThemeData primaryLight = ThemeData(
    canvasColor: Colors.white,
    primaryColor: blueDarkShade,
    primaryColorDark: blueDarkerShade,
    primaryColorLight: blueLightShade,
  );
  final ThemeData primaryDark = ThemeData(
    canvasColor: greyDarkerShade,
    primaryColor: purpleDarkerShade,
  );
}
