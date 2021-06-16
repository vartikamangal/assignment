// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:animator/animator.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

class ImagePositioning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scale = ScaleManager.imageScale.value;
    return Stack(
      children: [
        Animator<double>(
          tween: Tween<double>(
            begin: 0,
            end: 15,
          ),
          cycles: 0,
          duration: const Duration(
            milliseconds: 1800,
          ),
          curve: Curves.fastOutSlowIn,
          builder: (context, animatorState, child) => Center(
            child: Transform.translate(
              offset: Offset(
                0,
                -animatorState.value,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  ImagePath.holdingLeaf,
                  fit: BoxFit.cover,
                  scale: scale,
                ),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: ScaleManager.spaceScale(spaceing: 94).value,
                  right: ScaleManager.spaceScale(spaceing: 96.9).value),
              child: Image.asset(
                ImagePath.logo,
                height: ScaleManager.spaceScale(spaceing: 50).value,
                width: ScaleManager.spaceScale(spaceing: 237).value,
                scale: scale,
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScaleManager.spaceScale(spaceing: 46).value,
                  right: ScaleManager.spaceScale(spaceing: 50).value),
              child: Image.asset(
                ImagePath.tagLine,
                height: ScaleManager.spaceScale(spaceing: 27).value,
                width: ScaleManager.spaceScale(spaceing: 328).value,
                scale: scale,
              ),
            )
          ],
        ),
        Positioned(
          bottom: ScaleManager.spaceScale(
            spaceing: -20,
          ).value,
          child: Animator<double>(
            tween: Tween<double>(
              begin: 0,
              end: 15,
            ),
            cycles: 0,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(
              milliseconds: 1800,
            ),
            builder: (context, animatorState, child) => Center(
              child: Transform.translate(
                offset: Offset(
                  0,
                  -animatorState.value,
                ),
                child: SizedBox(
                  width: Get.width,
                  child: Image.asset(
                    ImagePath.mountain,
                    fit: BoxFit.cover,
                    scale: scale,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            bottom: ScaleManager.spaceScale(
              spaceing: 140.0,
            ).value,
            right: ScaleManager.spaceScale(
              spaceing: 15.0,
            ).value,
            child: Image.asset(
              ImagePath.greenVectors,
              height: ScaleManager.spaceScale(spaceing: 62).value,
              width: ScaleManager.spaceScale(spaceing: 106).value,
              scale: scale,
            )),
        Positioned(
          top: ScaleManager.spaceScale(
            spaceing: 10,
          ).value,
          right: ScaleManager.spaceScale(
            spaceing: 110,
          ).value,
          child: Animator<double>(
            tween: Tween<double>(
              begin: 0,
              end: 15,
            ),
            cycles: 0,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(
              milliseconds: 1800,
            ),
            builder: (context, animatorState, child) => Center(
              child: Transform.translate(
                offset: Offset(
                  -animatorState.value,
                  0,
                ),
                child: SizedBox(
                  width: Get.width,
                  child: Image.asset(
                    ImagePath.purpleVector,
                    height: ScaleManager.spaceScale(
                      spaceing: 46,
                    ).value,
                    width: ScaleManager.spaceScale(
                      spaceing: 126,
                    ).value,
                    scale: scale,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
