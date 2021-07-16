// Flutter imports:
// Package imports:
import 'dart:developer';

import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/linear-progress-indicator.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/controllers/rapport-content-according-to-mood.dart';

// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/animations/diagonal-animation-from-bottomright.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controllers/rapport-building-controller.dart.dart';
import 'customDropDownBtn.dart';

class MidPageContentC extends StatelessWidget {
  final String selectedEmotionIconUrl;
  final RapportBuildingController controller;
  const MidPageContentC({
    required this.selectedEmotionIconUrl,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    final imageScale = ScaleManager.imageScale.value;
    final textScale = ScaleManager.textScale.value;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Obx(
            () => controller.isProcessing.value
                ? CustomizedLinearProgressIndicator()
                : Container(),
          ),
          Positioned(
            right: 0,
            child: Image.asset(
              ImagePath.topRightLeaf,
              width: size.width,
              // fit: BoxFit.fitWidth,
              scale: imageScale,
            ),
          ),
          Positioned(
            left: ScaleManager.spaceScale(
              spaceing: 3,
            ).value,
            top: ScaleManager.spaceScale(
              spaceing: 9,
            ).value,
            child: TopAppBar(onPressed: () {
              controller.navigateBack();
            }),
          ),
          Container(
            padding: EdgeInsets.only(
              left: ScaleManager.spaceScale(
                spaceing: 32,
              ).value,
              right: ScaleManager.spaceScale(
                spaceing: 1,
              ).value,
            ),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 72,
                  ).value,
                ),
                // As per API : iconVo
                SizedBox(
                  width: ScaleManager.spaceScale(
                    spaceing: 89,
                  ).value,
                  height: ScaleManager.spaceScale(
                    spaceing: 88,
                  ).value,
                  child: DiagonalAnimation(
                    0.4,
                    CachedNetworkImage(
                      imageUrl: selectedEmotionIconUrl,
                      height: ScaleManager.spaceScale(
                        spaceing: 88,
                      ).value,
                    ),
                    1,
                    300.0,
                    400.0,
                    300,
                  ),
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 16,
                  ).value,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: ScaleManager.spaceScale(
                      spaceing: 50,
                    ).value,
                  ),
                  // As per API : content
                  child: Animator<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 1300),
                      builder: (context, animatorState, child) {
                        log(controller.selectedMood.value!.moodName!);
                        return Opacity(
                          opacity: animatorState.value,
                          child: Text(
                            rapportData[
                                    controller.selectedMood.value!.moodName!]!
                                .dropPageContent
                                .toString(),
                            style: AppTextStyle.titleM,
                            textScaleFactor: textScale,
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 16,
                  ).value,
                ),

                Padding(
                  padding: EdgeInsets.only(
                      right: ScaleManager.spaceScale(
                    spaceing: 30,
                  ).value),
                  // As per API : title
                  child: Animator<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 1300),
                      builder: (context, animatorState, child) => Opacity(
                            opacity: animatorState.value,
                            child: Text(
                              tr('ask time title'),
                              style: AppTextStyle.titleL,
                              textScaleFactor: textScale,
                            ),
                          )),
                ),

                SizedBox(
                  height: ScaleManager.spaceScale(spaceing: 25).value,
                ),
                Animator<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 1300),
                  curve: Curves.easeInOut,
                  builder: (context, animatorState, child) => Opacity(
                    opacity: animatorState.value,
                    child: Obx(
                      () => controller.isDropDownExpanded.value
                          ? customDropDownBtn(
                              color: blueDarkShade,
                              isExpanded: true,
                              options: controller.availableDurations,
                              label: controller.selectedFeelingDuration.value ==
                                      null
                                  ? tr('selection')
                                  : controller.selectedFeelingDuration.value!
                                      .durationDisplayName!
                                      .toUpperCase(),
                              // ignore: avoid_print
                              onPressed: () =>
                                  controller.toggleDropDownExpansion(),
                              controller: controller,
                            )
                          : customDropDownBtn(
                              color: blueDarkShade,
                              isExpanded: false,
                              label: controller.selectedFeelingDuration.value ==
                                      null
                                  ? tr('selection')
                                  : controller.selectedFeelingDuration.value!
                                      .durationDisplayName!
                                      .toUpperCase(),
                              // ignore: avoid_print
                              onPressed: () =>
                                  controller.toggleDropDownExpansion(),
                              // ignore: avoid_print
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => controller.isProcessing.value
                ? CustomizedLinearProgressIndicator()
                : Container(),
          ),
        ],
      ),
    );
  }
}
