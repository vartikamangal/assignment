import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:meta/meta.dart';
import '../color-pallete.dart';

import '../app-text-style-components/app-text-styles.dart';

class TopLeftGradientButtonExtended extends StatelessWidget {
  final Callback onPressed;
  final String label;
  const TopLeftGradientButtonExtended({
    @required this.onPressed,
    @required this.label,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
            left: 27, top: 17, bottom: 17, right: Get.width * 0.3),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(40)),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                blueDarkShade,
                blueLightShade,
              ],
            )),
        child: Row(
          children: [
            Image.asset("assets/intro-screen-a/images/call_button.png"),
            SizedBox(
              width: Get.width * 0.07,
            ),
            Flexible(
              child: Text(
                'I want to be directly connected to someone',
                style: AppTextStyle.buttonTextStyleSCanvas,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
