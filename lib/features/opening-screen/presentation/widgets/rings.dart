import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/color-pallete.dart';

class Rounds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Stack(
        children: [
          // Green ring near hand
          Positioned(
            top: -Get.height * 0.1338,
            left: Get.width * 0.16,
            child: Animator<double>(
              tween: Tween<double>(begin: 0, end: 12),
              duration: const Duration(seconds: 1),
              resetAnimationOnRebuild: true,
              cycles: 0,
              builder: (context, animatorState, child) => Center(
                child: Transform.translate(
                  offset: Offset(0, animatorState.value + 0.1),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: ScaleManager.spaceScale(
                      spaceing: 10,
                    ).value),
                    child: Container(
                      height: Get.height * 0.30,
                      width: Get.height * 0.30,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: greenLightShade,
                            width: ScaleManager.spaceScale(
                              spaceing: 4,
                            ).value),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Sun like object
          Positioned(
            bottom: Get.height * 0.13,
            left: Get.width * 0.44,
            child: Animator<double>(
              tween: Tween<double>(begin: 0, end: 30),
              duration: const Duration(milliseconds: 1500),
              resetAnimationOnRebuild: true,
              cycles: 0,
              builder: (context, animatorState, child) => Center(
                child: Transform.translate(
                  offset: Offset(0, -animatorState.value),
                  child: Container(
                    height: Get.height * 0.235,
                    width: Get.height * 0.235,
                    decoration: BoxDecoration(
                      color: aquashade,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
