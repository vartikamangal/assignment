import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/utils/animations/fade-animation-x-axis.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/presentation/controller/choose-path-controller.dart';

import '../../../../core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottom-right-text-button.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controller/path-controller.dart';

class PathInfoSection2 extends StatelessWidget {
  final PathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    final bool _isSmallWinsActivity =
        Get.find<ChoosePathController>().selectedJourney.value.pathName ==
            'SMALL_WINS';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed(RouteName.selfPathInfoSection1);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: blueDarkShade,
            size: ScaleManager.spaceScale(spaceing: 26).value,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScaleManager.spaceScale(spaceing: 17).value,
              ),
              Row(
                children: [
                  SizedBox(
                    width: ScaleManager.spaceScale(spaceing: Get.width * 0.32)
                        .value,
                  ),
                  Image.asset(
                    '${ImagePath.selfDrivenOption}physical.png',
                    height: ScaleManager.spaceScale(spaceing: 140).value,
                    width: ScaleManager.spaceScale(spaceing: 138).value,
                    scale: imageScaleFactor,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  left: ScaleManager.spaceScale(
                    spaceing: 28,
                  ).value,
                  right: ScaleManager.spaceScale(
                    spaceing: 28,
                  ).value,
                  top: ScaleManager.spaceScale(
                    spaceing: 30,
                  ).value,
                ),
                child: FadeAnimationXAxis(
                  0.1, Text(
                    _isSmallWinsActivity
                        ? _controller.selectedActivity.value.activity.title
                        : _controller.selectedDayPlan.value.title,
                    style: AppTextStyle.Askfeeling,
                    textScaleFactor: textScaleFactor,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: ScaleManager.spaceScale(
                    spaceing: 32,
                  ).value,
                  right: ScaleManager.spaceScale(
                    spaceing: 28,
                  ).value,
                ),
                child: FadeAnimationXAxis(
                  0.1, Text(
                    'Takes ${_controller.activityDuration} minutes',
                    style: AppTextStyle.getTimerText,
                    textScaleFactor: textScaleFactor,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: ScaleManager.spaceScale(
                      spaceing: 32,
                    ).value,
                    right: ScaleManager.spaceScale(
                      spaceing: 71,
                    ).value,
                    top: ScaleManager.spaceScale(
                      spaceing: 9,
                    ).value),
                child: FadeAnimationXAxis(
                  0.1, Text(
                    _isSmallWinsActivity
                        ? _controller
                            .templateToRecommendationMapperSelf['INSTRUCTIONS']
                            .stepContent
                        : _controller
                            .templateToRecommendationMapperGuided['INSTRUCTIONS']
                            .stepContent,
                    style: AppTextStyle.growthtext,
                    textScaleFactor: textScaleFactor,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: ScaleManager.spaceScale(
              spaceing: 12,
            ).value,
            bottom: ScaleManager.spaceScale(
              spaceing: 14,
            ).value,
            child: FadeAnimationXAxis(
              0.2, BottomRightTextButton(
                  title: tr('i got it'),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      RouteName.pathInfoSection3,
                    );
                  },
                ),
            ),
            ),
        ],
      ),
    );
  }
}
