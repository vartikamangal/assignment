import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/presentation/controller/choose-path-controller.dart';

import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottomRightButton.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controller/path-controller.dart';

class SelfPathSection1 extends StatelessWidget {
  final PathController controller = Get.find();
  SelfPathSection1({
    Key key,
  }) : super(key: key);

  Future<bool> _onWillPop({@required BuildContext context}) async {
    return (await Get.dialog(
          AlertDialog(
            title: const Text(
              'Do your really wish to stop this activity?',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'No',
                ),
              ),
              TextButton(
                onPressed: () async {
                  //? Will stop the activity before closing page or app
                  await controller.updateActivityStatusTrigger();
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  'Yes',
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    // Checks if this page is injecting activity of Small Wins or Big_Goals
    // Would have been better if we had same varNames
    final bool _isSmallWinsActivity =
        Get.find<ChoosePathController>().selectedJourney.value.pathName ==
            'SMALL_WINS';
    return WillPopScope(
      onWillPop: () => _onWillPop(context: context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              await _onWillPop(context: context) ? Get.back() : log('Nope');
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
                  height: ScaleManager.spaceScale(
                    spaceing: 15,
                  ).value,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: ScaleManager.spaceScale(
                        spaceing: Get.width * 0.32,
                      ).value,
                    ),
                    //TODO change this after
                    Image.asset(
                      '${ImagePath.selfDrivenOption}physical.png',
                      height: ScaleManager.spaceScale(
                        spaceing: 140,
                      ).value,
                      width: ScaleManager.spaceScale(
                        spaceing: 138,
                      ).value,
                      scale: imageScaleFactor,
                    ),
                  ],
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 30,
                  ).value,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: ScaleManager.spaceScale(
                      spaceing: 44,
                    ).value,
                  ),
                  child: Text(
                    _isSmallWinsActivity
                        ? controller
                            .templateToRecommendationMapperSelf['DID_YOU_KNOW']
                            .stepTitle
                        : controller
                            .templateToRecommendationMapperGuided[
                                'DID_YOU_KNOW']
                            .stepTitle,
                    style: AppTextStyle.Askfeeling,
                    textScaleFactor: textScaleFactor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScaleManager.spaceScale(spaceing: 44).value),
                  child: Text(
                    'Takes ${controller.activityDuration} minutes',
                    style: AppTextStyle.getTimerText,
                    textScaleFactor: textScaleFactor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: ScaleManager.spaceScale(
                      spaceing: 44,
                    ).value,
                    right: ScaleManager.spaceScale(
                      spaceing: 71,
                    ).value,
                    top: ScaleManager.spaceScale(
                      spaceing: 9,
                    ).value,
                  ),
                  child: Text(
                    _isSmallWinsActivity
                        ? controller
                            .templateToRecommendationMapperSelf['DID_YOU_KNOW']
                            .stepContent
                        : controller
                            .templateToRecommendationMapperGuided[
                                'DID_YOU_KNOW']
                            .stepContent,
                    style: AppTextStyle.growthtext,
                    textScaleFactor: textScaleFactor,
                  ),
                )
              ],
            ),
            Positioned(
              right: ScaleManager.spaceScale(spaceing: 12).value,
              bottom:
                  ScaleManager.spaceScale(spaceing: 13).value,
              child:  BottomRightButton(
                  title: '',
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      RouteName.pathInfoSection2,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
