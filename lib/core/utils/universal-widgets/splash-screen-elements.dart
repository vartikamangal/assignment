import 'package:flutter/material.dart';
import 'images_positioning.dart';
import 'rings.dart';
import 'upper_layer.dart';

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
