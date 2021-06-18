import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/images_positioning.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/rings.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/upper_layer.dart';

class SplashScreenElements extends StatelessWidget {
  const SplashScreenElements({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Rounds(),
        ImagePositioning(),
        UpperLayer(),
      ],
    );
  }
}
