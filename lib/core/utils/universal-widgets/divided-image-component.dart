import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

import '../color-pallete.dart';

Widget DividedImageComponent({@required String imgUrl}) {
  final imageScaleFactor = ScaleManager.imageScale.value;
  return SizedBox(
    height: ScaleManager.spaceScale(
      spaceing: 130,
    ).value,
    child: Stack(
      children: [
        Align(
          child: Divider(
            color: greyline,
          ),
        ),
        Align(
          child: SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 92,
            ).value,
            width: ScaleManager.spaceScale(
              spaceing: 91,
            ).value,
            child: Image.asset(
              imgUrl,
              scale: imageScaleFactor,
            ),
          ),
        ),
      ],
    ),
  );
}
