import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import '../../../../core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottom-left-gradient-button.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/utils/universal-widgets/day-selector-box.dart';

class OnBoardingIncomplete extends StatelessWidget {
  final List<String> days = [
    'S',
    'M',
    'T',
    'W',
    'T',
    'F',
    'S',
  ];
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: ScaleManager.spaceScale(spaceing: 10).value,
              right: ScaleManager.spaceScale(spaceing: 10).value,
              child: BottomLeftGradientButton(onPressed: () {
                Navigator.pushNamed(context, RouteName.instantRelief);
              }),
            ),
            Positioned(
              top: ScaleManager.spaceScale(spaceing: 10).value,
              left: ScaleManager.spaceScale(spaceing: 10).value,
              child: Image.asset(
                ImagePath.cornerImage,
                height: ScaleManager.spaceScale(spaceing: 43).value,
                width: ScaleManager.spaceScale(spaceing: 43).value,
                scale: imageScaleFactor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: ScaleManager.spaceScale(spaceing: 90).value),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagePath.onBoardingIncompleteImage,
                        height: ScaleManager.spaceScale(spaceing: 94).value,
                        width: ScaleManager.spaceScale(spaceing: 94).value,
                        scale: imageScaleFactor,
                      ),
                      SizedBox(
                        width: ScaleManager.spaceScale(spaceing: 16).value,
                      ),
                      Text(
                        'Hello Bhavna',
                        style: AppTextStyle.boldDarkBlueText,
                        textScaleFactor: textScaleFactor,
                      ),
                    ],
                  ),
                  SizedBox(height: ScaleManager.spaceScale(spaceing: 10).value),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScaleManager.spaceScale(spaceing: 44).value,
                        right: ScaleManager.spaceScale(spaceing: 43).value),
                    width: ScaleManager.spaceScale(spaceing: Get.width).value,
                    height: ScaleManager.spaceScale(spaceing: 1).value,
                    color: greyline,
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(spaceing: 6).value,
                  ),
                  Text(
                    tr('starting day'),
                    style: AppTextStyle.startingDayText,
                    textScaleFactor: textScaleFactor,
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(spaceing: 15).value,
                  ),
                  Text(
                    'Focus : the mind',
                    style: AppTextStyle.darkerTitle,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: ScaleManager.spaceScale(spaceing: 5).value,
                        left: ScaleManager.spaceScale(spaceing: 16).value,
                        right: ScaleManager.spaceScale(spaceing: 19).value),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: days.map((day) => daySelector(day)).toList()),
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(spaceing: 23).value,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScaleManager.spaceScale(spaceing: 44).value,
                        right: ScaleManager.spaceScale(spaceing: 43).value),
                    width: Get.width,
                    height: ScaleManager.spaceScale(spaceing: 1).value,
                    color: greyline,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScaleManager.spaceScale(spaceing: 70).value,
                        right: ScaleManager.spaceScale(spaceing: 60).value),
                    child: Text(
                      tr('gratitude journal finished'),
                      style: AppTextStyle.greyHint,
                      textAlign: TextAlign.center,
                      textScaleFactor: textScaleFactor,
                    ),
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(spaceing: 20).value,
                  ),
                  Text(
                    tr('remaining thing'),
                    style: AppTextStyle.greyHint,
                    textScaleFactor: textScaleFactor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
