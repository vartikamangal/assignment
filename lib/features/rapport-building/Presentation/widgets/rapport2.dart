import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../controllers/rapport-building-controller.dart.dart';
import 'emotion_selector.dart';

class MidPageContentB extends StatelessWidget {
  final RapportBuildingController onBoardingController;

  const MidPageContentB({Key key, @required this.onBoardingController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textScale = ScaleManager.textScale.value;
    return Container(
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
            height: Get.height * 0.23,
          ),
          Obx(
            () => Padding(
              padding: EdgeInsets.only(
                right: ScaleManager.spaceScale(
                  spaceing: 96,
                ).value,
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
            width: Get.width * 0.75,
            child: Text(
              tr('ask feeling title'),
              style: AppTextStyle.titleL,
              textScaleFactor: textScale,
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
              () => Row(
                // ignore: invalid_use_of_protected_member
                children: onBoardingController.moods.value
                    .map(
                      (mood) => emotionSelector(
                        mood.moodName.toLowerCase(),
                        () {
                          onBoardingController.setEmotion(
                            mood.moodName.toLowerCase(),
                            mood,
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
