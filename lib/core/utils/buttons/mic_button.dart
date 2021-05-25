import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '../../asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

import '../color-pallete.dart';

class Mic_Button extends StatelessWidget {
  final Callback onpressed;
  const Mic_Button({this.onpressed});
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: ScaleManager.spaceScale(spaceing: 40).value,
        width: ScaleManager.spaceScale(spaceing: 40).value,
        margin: EdgeInsets.all(
          ScaleManager.spaceScale(
            spaceing: 6,
          ).value,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              ScaleManager.spaceScale(
                spaceing: 40,
              ).value,
            ),
          ),
          color: blueDarkShade,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SvgPicture.asset(
            ImagePath.micImage,
          ),
        ),
      ),
    );
  }
}
