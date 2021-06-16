// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import '../../asset-image-path/image-path.dart';
import '../../responsive/scale-manager.dart';
import '../color-pallete.dart';

class Mic_Button extends StatelessWidget {
  final Callback onpressed;
  const Mic_Button({this.onpressed});
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    return Container(
      height: ScaleManager.spaceScale(spaceing: 40).value,
      width: ScaleManager.spaceScale(spaceing: 40).value,
      margin: EdgeInsets.all(
        ScaleManager.spaceScale(
          spaceing: 0,
        ).value,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: blueDarkShade,
      ),
      child: Padding(
        padding:  EdgeInsets.all( ScaleManager.spaceScale(
          spaceing: 7,
        ).value),
        child: SvgPicture.asset(
          ImagePath.micImage,
        ),
      ),
    );
  }
}
