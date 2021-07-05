import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';

class CustomizedLinearProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(blueLightShade),);
  }
}
