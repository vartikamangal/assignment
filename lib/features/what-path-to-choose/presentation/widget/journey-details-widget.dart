// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/presentation/controller/choose-path-controller.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/animations/fade-animation-x-axis.dart';
import '../../../../core/utils/buttons/bottom-right-text-button.dart';
import '../../../../core/utils/universal-widgets/divided-image-component.dart';
import '../../../../core/utils/universal-widgets/text-description-box.dart';
import '../../domain/entites/journey.dart';

class JourneyDetails extends StatelessWidget {
  final Journey? journey;
  final VoidCallback startJourneyFunction;


  const JourneyDetails({
    Key? key,
    required this.journey,
    required this.startJourneyFunction,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ChoosePathController controller = Get.find();
    final imageScale = ScaleManager.imageScale.value;
    final String journeyIconUrl =
        'assets/choose-path-screen/${journey!.pathName}.png';
    final String journeyLabelImageUrl =
        'assets/choose-path-screen/${journey!.pathName}_LABEL.png';
    return FadeAnimationXAxis(
      0.4,
      Stack(
        children: [
          Positioned(
            top: ScaleManager.spaceScale(
              spaceing: 31,
            ).value,
            left: ScaleManager.spaceScale(
              spaceing: 68,
            ).value,
            child: Image.asset(
              journeyLabelImageUrl,
              height: ScaleManager.spaceScale(
                spaceing: 287,
              ).value,
              width: ScaleManager.spaceScale(
                spaceing: 265,
              ).value,
              scale: imageScale,
            ),
          ),
            Padding(
              padding: EdgeInsets.only(
                left: ScaleManager.spaceScale(
                  spaceing: 47,
                ).value,
                right: ScaleManager.spaceScale(
                  spaceing: 40,
                ).value,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: ScaleManager.spaceScale(
                        spaceing: 285,
                      ).value,
                    ),
                  ),
                Obx(()=>  DividedImageComponent(
                  imgUrl: journey!.icon!.url,
                ),),
                  Expanded(
                    flex: 3,
                    child: TextDescriptionBox(
                      title: journey!.title,
                      description: journey!.subtitle,
                      week: tr('first week'),
                      category: tr('category1'),
                      suggestion1: 'Yogasana',
                      suggestion2: 'Pranayama',
                      suggestion3: 'Weight training',
                      suggestion4: 'Rock climbing',
                      suggestion5: 'Run',
                    ),
                  ),
                ],
              ),
            ),
          Positioned(
            right: ScaleManager.spaceScale(
              spaceing: 12,
            ).value,
            bottom: ScaleManager.spaceScale(
              spaceing: 13,
            ).value,
            child: FadeAnimationXAxis(
              0.25,
              BottomRightTextButton(
                title: tr('lets go').toUpperCase(),
                onPressed: startJourneyFunction,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
