import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/widgets/customDropDownBtn.dart';

import '../../../../core/utils/animations/diagonal-animation-from-bottomright.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';

class MidPageContentC extends StatelessWidget {
  final String selectedEmotion;
  final RapportBuildingController controller;
  const MidPageContentC({
    @required this.selectedEmotion,
    @required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    final imageScale = ScaleManager.imageScale.value;
    final textScale = ScaleManager.textScale.value;
    return
      Container(
        padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(
              spaceing: 32,
            ).value,
            right: ScaleManager.spaceScale(
              spaceing: 1,
            ).value),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.06,
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
                0.4, Image.asset(
                  '${ImagePath.lightBlueEmoji}${'$selectedEmotion.png'}',
                  scale: imageScale,
                ),
              ),
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 20,
              ).value,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: ScaleManager.spaceScale(
                  spaceing: 88,
                ).value,
              ),
              // As per API : content
              child: Text(
                tr('ask time text'),
                style: AppTextStyle.titleM,
                textScaleFactor: textScale,
              ),
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 30,
              ).value,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: ScaleManager.spaceScale(
                spaceing: 30,
              ).value),
              // As per API : title
              child: Text(
                tr('ask time title'),
                style: AppTextStyle.titleL,
                textScaleFactor: textScale,
              ),
            ),
            SizedBox(
              height: ScaleManager.spaceScale(spaceing: 15).value,
            ),
            Obx(
              () => controller.isDropDownExpanded.value
                  ? customDropDownBtn(
                      color: blueDarkShade,
                      isExpanded: true,
                      options: controller.availableDurations,
                      label: controller.selectedFeelingDuration.value == null
                          ? tr('selection')
                          : controller
                              .selectedFeelingDuration.value.durationDisplayName
                              .toUpperCase(),
                      // ignore: avoid_print
                      onPressed: () => controller.toggleDropDownExpansion(),
                      controller: controller,
                    )
                  : customDropDownBtn(
                      color: blueDarkShade,
                      isExpanded: false,
                      label: controller.selectedFeelingDuration.value == null
                          ? tr('selection')
                          : controller
                              .selectedFeelingDuration.value.durationDisplayName
                              .toUpperCase(),
                      // ignore: avoid_print
                      onPressed: () => controller.toggleDropDownExpansion(),
                      // ignore: avoid_print
                    ),
            ),
          ],
        ),
    );
  }
}
