import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';

class DayWisePlanBox extends StatelessWidget {
  String title;
  String image;
  Callback onPressed;
  DayWisePlanBox({this.title, this.image, this.onPressed});
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: ScaleManager.spaceScale(spaceing: 85).value,
                width: ScaleManager.spaceScale(spaceing: Get.width).value,
                margin: EdgeInsets.only(
                    top: ScaleManager.spaceScale(spaceing: 4).value,
                    left: ScaleManager.spaceScale(spaceing: 25).value),
                decoration: BoxDecoration(
                    border: Border.all(color: greyLightShade),
                    borderRadius: BorderRadius.all(Radius.circular(
                        ScaleManager.spaceScale(spaceing: 42.5).value))),
                child: Container(
                  margin: EdgeInsets.only(
                      left: ScaleManager.spaceScale(spaceing: 80).value),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: ScaleManager.spaceScale(spaceing: 20).value,
                      ),
                      Text(
                        title,
                        style: AppTextStyle.Darkblueheader,
                        textAlign: TextAlign.center,
                        textScaleFactor: textScaleFactor,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  image,
                  height: ScaleManager.spaceScale(spaceing: 91).value,
                  scale: imageScaleFactor,
                ),
              ),
            ],
          ),
          SizedBox(height: ScaleManager.spaceScale(spaceing: 40).value)
        ],
      ),
    );
  }
}
