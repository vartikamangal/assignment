// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import '../../responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';
import '../color-pallete.dart';

class MiddleCallUsButton extends StatelessWidget {
  final String title;
  final Callback onPressed;
  const MiddleCallUsButton({this.onPressed, this.title});
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
          spaceing: 153,
        ).value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ScaleManager.spaceScale(
              spaceing: 25,
            ).value),
            bottomRight: Radius.circular(
              ScaleManager.spaceScale(
                spaceing: 25,
              ).value,
            ),
          ),
          color: blueDarkShade,
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.buttonTextStyle,
            textScaleFactor: textScaleFactor,
          ),
        ),
      ),
    );
  }
}
