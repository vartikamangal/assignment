// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import '../../asset-image-path/image-path.dart';
import '../../responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';
import '../color-pallete.dart';

class TopRightCallbutton extends StatelessWidget {
  final Callback? onPressed;
  const TopRightCallbutton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(spaceing: 15).value,
            bottom: ScaleManager.spaceScale(spaceing: 18).value,
            top: ScaleManager.spaceScale(spaceing: 20).value,
            right: ScaleManager.spaceScale(spaceing: 17).value),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                    ScaleManager.spaceScale(spaceing: 25).value),
                topLeft: Radius.circular(
                    ScaleManager.spaceScale(spaceing: 25).value)),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                blueLightShade,
                blueDarkShade,
              ],
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: ScaleManager.spaceScale(
                spaceing: 10,
              ).value,
            ),
            Text(
              tr('sos helpline'),
              style: AppTextStyle.buttontitleS,
              textScaleFactor: textScaleFactor,
            ),
            SizedBox(
              width: ScaleManager.spaceScale(
                spaceing: 20,
              ).value,
            ),
            SvgPicture.asset(
              ImagePath.callButton,
              height: ScaleManager.spaceScale(
                spaceing: 25,
              ).value,
              width: ScaleManager.spaceScale(
                spaceing: 25,
              ).value,
            ),
          ],
        ),
      ),
    );
  }
}
