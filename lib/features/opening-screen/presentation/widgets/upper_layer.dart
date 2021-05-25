import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/color-pallete.dart';

class UpperLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Stack(
        children: [
          // Purple circle on thegreen ring
          Positioned(
            top: Get.height * 0.165,
            left: Get.width * 0.309,
            child: Animator<double>(
              tween: Tween<double>(begin: 0, end: 12),
              duration: const Duration(milliseconds: 1100),
              cycles: 0,
              builder: (context, animatorState, child) => Center(
                child: Transform.translate(
                  offset:
                      Offset(animatorState.value * 0.5, -animatorState.value),
                  child: Container(
                    height: Get.height * 0.0259,
                    width: Get.height * 0.0259,
                    decoration: BoxDecoration(
                      color: purpleDarkerShade,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // light sky blue circle near hand
          Positioned(
            top: Get.height * 0.05,
            left: Get.width * 0.73,
            child: Animator<double>(
              tween: Tween<double>(begin: 0, end: 12),
              duration: const Duration(milliseconds: 1100),
              cycles: 0,
              builder: (context, animatorState, child) => Center(
                child: Transform.translate(
                  offset: Offset(
                      animatorState.value * 0.1, animatorState.value + 0.3),
                  child: Container(
                    height: Get.height * 0.037,
                    width: Get.height * 0.037,
                    decoration: BoxDecoration(
                      color: aquashade,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          //Drak green round
          Positioned(
            top: Get.height * 0.24,
            left: Get.width * 0.67,
            child: Animator<double>(
              tween: Tween<double>(begin: 0, end: 12),
              duration: const Duration(milliseconds: 1100),
              cycles: 0,
              builder: (context, animatorState, child) => Center(
                child: Transform.translate(
                  offset: Offset(
                      -animatorState.value * 0.2, animatorState.value * 0.7),
                  child: Container(
                    height: Get.height * 0.017,
                    width: Get.height * 0.017,
                    decoration: BoxDecoration(
                      color: greenDarkShade,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          //dark green circle near mountain
          Positioned(
            bottom: Get.height * 0.36,
            left: Get.width * 0.44,
            child: Animator<double>(
              tween: Tween<double>(begin: 0, end: 12),
              duration: const Duration(milliseconds: 3000),
              cycles: 0,
              builder: (context, animatorState, child) => Center(
                child: Transform.translate(
                  offset:
                      Offset(-animatorState.value * 0.7, animatorState.value),
                  child: Container(
                    height: Get.height * 0.015,
                    width: Get.height * 0.015,
                    decoration: BoxDecoration(
                      color: greenDarkShade,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: Get.height * 0.2107,
            left: Get.width * 0.81,
            child: Animator<double>(
              tween: Tween<double>(begin: 0, end: 40),
              duration: const Duration(milliseconds: 3000),
              cycles: 0,
              builder: (context, animatorState, child) => Center(
                child: Transform.translate(
                  offset:
                      Offset(-animatorState.value * 0.4, animatorState.value),
                  child: Container(
                    height: Get.height * 0.025,
                    width: Get.height * 0.025,
                    decoration: BoxDecoration(
                      color: aquashade,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Get.height * 0.32,
            left: Get.width * 0.40,
            child: Animator<double>(
              tween: Tween<double>(begin: 0, end: 8),
              duration: const Duration(milliseconds: 2500),
              cycles: 0,
              builder: (context, animatorState, child) => Center(
                child: Transform.translate(
                  offset:
                      Offset(-animatorState.value * 0.7, animatorState.value),
                  child: Container(
                    height: Get.height * 0.034,
                    width: Get.height * 0.034,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: purpleDarkerShade,
                          width: ScaleManager.spaceScale(
                            spaceing: 3,
                          ).value),
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
