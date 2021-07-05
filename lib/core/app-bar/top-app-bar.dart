import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

class TopAppBar extends StatelessWidget {
  final Callback onPressed;
  TopAppBar({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    return IconButton(
      padding: EdgeInsets.only(
          left: ScaleManager.spaceScale(
            spaceing: 10,
          ).value,
          top: ScaleManager.spaceScale(
            spaceing: 10,
          ).value,
          bottom: 0),
      icon: Image.asset(
        ImagePath.backButton,
        scale: imageScaleFactor,
        height: ScaleManager.spaceScale(
          spaceing: 26,
        ).value
      ),
      onPressed: onPressed,
    );
  }
}
