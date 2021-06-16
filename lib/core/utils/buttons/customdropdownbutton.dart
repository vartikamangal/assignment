// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import '../../responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';

Widget customDropDownBtn({
  String label,
  Callback onPressed,
  Color color,
}) {
  final textScaleFactor = ScaleManager.textScale.value;
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.only(
          top: ScaleManager.spaceScale(spaceing: 10).value,
          bottom: ScaleManager.spaceScale(spaceing: 10).value,
          left: ScaleManager.spaceScale(spaceing: 10).value,
          right: ScaleManager.spaceScale(spaceing: 10).value),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft:
                Radius.circular(ScaleManager.spaceScale(spaceing: 20).value),
            topRight:
                Radius.circular(ScaleManager.spaceScale(spaceing: 20).value),
            bottomLeft:
                Radius.circular(ScaleManager.spaceScale(spaceing: 20).value),
          )),
      child: Text(
        label,
        style: AppTextStyle.dropDownStyle,
        textScaleFactor: textScaleFactor,
      ),
    ),
  );
}
