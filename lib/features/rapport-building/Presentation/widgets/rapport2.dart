// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import 'emotion_selector.dart';

class MidPageContentB extends StatelessWidget {
  final RapportBuildingController onBoardingController;

  const MidPageContentB({Key key, @required this.onBoardingController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final scale = ScaleManager.imageScale.value;
    final textScale = ScaleManager.textScale.value;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Obx(
                () => onBoardingController.isProcessing.value
                ? const LinearProgressIndicator()
                : Container(),
          ),
          Positioned(
            right: 0,
            child: Image.asset(
              ImagePath.topRightLeaf,
              width: size.width,
              // fit: BoxFit.fitWidth,
              scale: scale,
            ),
          ),
          Positioned(
            left: ScaleManager.spaceScale(
              spaceing: 3,
            ).value,
            top: ScaleManager.spaceScale(
              spaceing: 9,
            ).value,
            child: TopAppBar(onPressed: (){onBoardingController.navigateBack();})
          ),
          Container(
            padding: EdgeInsets.only(
                right: ScaleManager.spaceScale(
                  spaceing: 1,
                ).value),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.27,
                ),
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(
                      right: ScaleManager.spaceScale(
                        spaceing: 96,
                      ).value,
                        left: ScaleManager.spaceScale(
                          spaceing: 32,
                        ).value
                    ),
                    child: Text(
                      tr(
                        'ask feeling text',
                        namedArgs: {
                          'name': '${onBoardingController.userName}',
                        },
                      ),
                      textScaleFactor: textScale,
                      style: AppTextStyle.titleM,
                    ),
                  ),
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 15,
                  ).value,
                ),
                SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScaleManager.spaceScale(
                          spaceing: 32,
                        ).value
                    ),
                    child: Text(
                      tr('ask feeling title'),
                      style: AppTextStyle.titleL,
                      textScaleFactor: textScale,
                    ),
                  ),
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 28,
                  ).value,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Get.width,
                  ),
                  child: Obx(
                    () => Padding(
                      padding: EdgeInsets.only(
                          left: ScaleManager.spaceScale(
                            spaceing: 22,
                          ).value
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: onBoardingController.moods.value
                            .map(
                              (mood) => emotionSelector(
                                mood.moodName.toLowerCase(),
                                () {
                                  !onBoardingController.isProcessing.value?
                                  onBoardingController.setEmotion(
                                    mood.moodName.toLowerCase(),
                                    mood,
                                  ): Container();
                                },
                                height: 48,
                                width: 48.32,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
