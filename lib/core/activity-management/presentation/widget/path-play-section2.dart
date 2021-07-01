// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';

// Project imports:
import 'package:tatsam_app_experimental/features/what-path-to-choose/presentation/controller/choose-path-controller.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controller/path-controller.dart';

class PathPlaySection2 extends StatelessWidget {
  final PathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    final bool _isSmallWinsActivity =
        Get.find<ChoosePathController>().selectedJourney.value.pathName ==
            'SMALL_WINS';
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: ScaleManager.spaceScale(spaceing: 9).value,
              left: ScaleManager.spaceScale(spaceing: 9).value,
              child: TopAppBar(onPressed: (){ Navigator.popAndPushNamed(
                  context, RouteName.pathInfoSection3);})
            ),
            Container(
              margin: EdgeInsets.only(
                  top: ScaleManager.spaceScale(spaceing: 60).value,
                  left: ScaleManager.spaceScale(spaceing: 17).value),
              child: Column(
                children: [
                  Text(
                    'Awesome!',
                    style: AppTextStyle.appreciationtext,
                    textScaleFactor: textScaleFactor,
                  ),
                  Text(
                    'You just finished your first practice!',
                    style: AppTextStyle.actiontoperform,
                    textScaleFactor: textScaleFactor,
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(spaceing: 10).value,
                  ),
                  Image.asset(
                    '${ImagePath.selfDrivenOption}physical.png',
                    height: ScaleManager.spaceScale(spaceing: 70).value,
                    width: ScaleManager.spaceScale(spaceing: 69).value,
                    scale: imageScaleFactor,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: ScaleManager.spaceScale(spaceing: 20).value),
                    child: Text(
                      _isSmallWinsActivity
                          ? _controller.selectedActivity.value.activity.title
                          : _controller.selectedDayPlan.value.title,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: ScaleManager.spaceScale(spaceing: 10).value,
                          left: ScaleManager.spaceScale(spaceing: 40).value,
                          right: ScaleManager.spaceScale(spaceing: 56).value),
                      child: Text(
                        tr('play section message1'),
                        style: AppTextStyle.growthtext,
                        textAlign: TextAlign.center,
                        textScaleFactor: textScaleFactor,
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScaleManager.spaceScale(spaceing: 17).value,
                        right: ScaleManager.spaceScale(spaceing: 16).value,
                        top: ScaleManager.spaceScale(spaceing: 15).value),
                    child: Text(
                      tr('ask about experience'),
                      style: AppTextStyle.askExperienceText,
                      textAlign: TextAlign.center,
                      textScaleFactor: textScaleFactor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
FadeAnimationXAxis(
                  0.7,
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: Get.width,
                    ),
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
 */
