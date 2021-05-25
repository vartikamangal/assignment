import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:meta/meta.dart';
import '../../asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

import '../color-pallete.dart';

class BottomLeftGradientButton extends StatelessWidget {
  final Callback onPressed;
  const BottomLeftGradientButton({
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: ScaleManager.spaceScale(
          spaceing: 40,
        ).value,
        width: ScaleManager.spaceScale(
          spaceing: 40,
        ).value,
        padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(spaceing: 10).value,
            right: ScaleManager.spaceScale(spaceing: 10).value,
            bottom: ScaleManager.spaceScale(spaceing: 10).value,
            top: ScaleManager.spaceScale(spaceing: 10).value),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                blueDarkShade,
                blueLightShade,
              ],
            )),
        child: SvgPicture.asset(
          ImagePath.callButton,
        ),
      ),
    );
  }
}
