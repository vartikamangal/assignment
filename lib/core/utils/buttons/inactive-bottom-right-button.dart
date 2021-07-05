// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Package imports:
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';

// Project imports:
import '../../responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';
import '../color-pallete.dart';

class InactiveBottomRightButton extends StatelessWidget {
  final String? title;
  final Callback? onPressed;
  const InactiveBottomRightButton({
    this.onPressed,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: ScaleManager.spaceScale(
          spaceing: 56,
        ).value,
        width: ScaleManager.spaceScale(
          spaceing: 97,
        ).value,
        padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(
              spaceing: 56,
            ).value,
            right: ScaleManager.spaceScale(
              spaceing: 17,
            ).value,
            top: ScaleManager.spaceScale(
              spaceing: 18,
            ).value,
            bottom: ScaleManager.spaceScale(
              spaceing: 17,
            ).value),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              ScaleManager.spaceScale(
                spaceing: 25,
              ).value,
            ),
            bottomRight: Radius.circular(
              ScaleManager.spaceScale(
                spaceing: 25,
              ).value,
            ),
          ),
          color: greyLightShade,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(ImagePath.forwardIcon,
              height: ScaleManager.spaceScale(
                spaceing: 19,
              ).value,)
          ],
        ),
      ),
    );
  }
}