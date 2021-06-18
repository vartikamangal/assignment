// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/animations/diagonal-animation-from-bottomright.dart';
import '../../../../core/utils/animations/end-with-fade-diagonal%20animation.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controllers/rapport-building-controller.dart.dart';
import 'customDropDownBtn.dart';

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
    return Stack(
      children: [
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
                  spaceing: 72 + MediaQuery.of(context).padding.top,
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
                  Image.asset(
                    '${ImagePath.lightBlueEmoji}${'$selectedEmotion.png'}',
                    scale: imageScale,
                  ),
                  1.0,
                  Get.width * 0.50,
                  Get.height * 0.50,
                  300,
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
                child: DiagonalAnimation(
                    0.7,
                    Text(
                      tr('ask time text'),
                      style: AppTextStyle.titleM,
                      textScaleFactor: textScale,
                    ),
                    1.0,
                    1.0,
                    1.0,
                    1),
              ),
              SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 30,
                ).value,
              ),
              DiagonalAnimation(
                  0.7,
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
                  1.0,
                  1.0,
                  1.0,
                  1),
              SizedBox(
                height: ScaleManager.spaceScale(spaceing: 15).value,
              ),
              DiagonalAnimation(
                  0.7,
                  Obx(
                    () => controller.isDropDownExpanded.value
                        ? customDropDownBtn(
                            color: blueDarkShade,
                            isExpanded: true,
                            options: controller.availableDurations,
                            label:
                                controller.selectedFeelingDuration.value == null
                                    ? tr('selection')
                                    : controller.selectedFeelingDuration.value
                                        .durationDisplayName
                                        .toUpperCase(),
                            // ignore: avoid_print
                            onPressed: () =>
                                controller.toggleDropDownExpansion(),
                            controller: controller,
                          )
                        : customDropDownBtn(
                            color: blueDarkShade,
                            isExpanded: false,
                            label:
                                controller.selectedFeelingDuration.value == null
                                    ? tr('selection')
                                    : controller.selectedFeelingDuration.value
                                        .durationDisplayName
                                        .toUpperCase(),
                            // ignore: avoid_print
                            onPressed: () =>
                                controller.toggleDropDownExpansion(),
                            // ignore: avoid_print
                          ),
                  ),
                  1.0,
                  1.0,
                  1.0,
                  1),
            ],
          ),
        ),
        FadedDiagonalEndAnimation(
            0.4,
            0.0,
            Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: blueDarkShade,
                  size: ScaleManager.spaceScale(
                    spaceing: 24,
                  ).value,
                )),
            -Get.width * 0.5,
            -Get.height * 0.5,
            400),
        FadedDiagonalEndAnimation(
            0.4,
            0.0,
            Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                    height: 30,
                    child: Image.asset(
                        '${ImagePath.lightBlueEmoji}${'$selectedEmotion.png'}',
                        scale: 0.2))),
            Get.width * 0.5,
            -Get.height * 0.5,
            400),
      ],
    );
  }
}
