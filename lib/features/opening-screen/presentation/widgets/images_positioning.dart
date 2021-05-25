import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImagePositioning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textScale = ScaleManager.textScale.value;
    final scale = ScaleManager.imageScale.value;
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Stack(
        children: [
          Animator<double>(
            tween: Tween<double>(begin: 0, end: 6),
            cycles: 0,
            duration: const Duration(seconds: 1),
            builder: (context, animatorState, child) => Center(
              child: Transform.translate(
                offset: Offset(0, -animatorState.value),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    ImagePath.holdingLeaf,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.40,
            child: Column(
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
                  height: size.height * 0.01,
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
          ),
          Positioned(
            bottom: -5,
            child: Animator<double>(
              tween: Tween<double>(begin: 0, end: 15),
              cycles: 0,
              duration: const Duration(milliseconds: 1500),
              builder: (context, animatorState, child) => Center(
                child: Transform.translate(
                  offset: Offset(0, animatorState.value),
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
              top: Get.height * 0.67,
              right: Get.width * 0.05,
              child: Image.asset(
                ImagePath.greenVectors,
                height: ScaleManager.spaceScale(spaceing: 62).value,
                width: ScaleManager.spaceScale(spaceing: 106).value,
                scale: scale,
              )),
          Positioned(
            top: Get.height * 0.015,
            left: Get.width * 0.10,
            child: Image.asset(
              ImagePath.purpleVector,
              height: ScaleManager.spaceScale(spaceing: 46).value,
              width: ScaleManager.spaceScale(spaceing: 126).value,
              scale: scale,
            ),
          )
        ],
      ),
    );
  }
}
