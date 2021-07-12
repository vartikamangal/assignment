// Dart imports:

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/perform-activity-controller.dart';

// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottomRightButton.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';

// main(List<String> args) {
//   DidYouKnowScreen.pageName
// }

class DidYouKnowScreen extends StatelessWidget {
  static String pageName = "DID_YOU_KNOW";
  DidYouKnowScreen({
    Key? key,
  }) : super(key: key);

  final PerformActivityController _activityController = Get.find();

  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    final activityDuration =
        _activityController.activity.value!.durationInMinutes.toString();
    return WillPopScope(
      onWillPop: () => _activityController.refreshStateOnBackButtonPress(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: Get.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PreferredSize(
                        preferredSize: Size(Get.width, 2),
                        child: EmptySpacePlaceHolder(),
                      ),
                      TopAppBar(
                        onPressed: () async {
                          /// In this case Flutter was just popping the DialogBox
                          /// and assuming that it has popped the page
                          /// That's why we have cross-checked if user want to quit
                          final toPop = await _activityController
                              .refreshStateOnBackButtonPress();
                          if (toPop) {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      SizedBox(
                        height: ScaleManager.spaceScale(
                          spaceing: 23,
                        ).value,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //TODO change this after
                          Hero(
                            tag: '${ImagePath.selfDrivenOption}physical.png',
                            child: Image.asset(
                              '${ImagePath.selfDrivenOption}physical.png',
                              height: ScaleManager.spaceScale(
                                spaceing: 140,
                              ).value,
                              width: ScaleManager.spaceScale(
                                spaceing: 138,
                              ).value,
                              scale: imageScaleFactor,
                            ),
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
                          _activityController.activeStep.value!.stepTitle!,
                          style: AppTextStyle.Askfeeling,
                          textScaleFactor: textScaleFactor,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScaleManager.spaceScale(spaceing: 44).value),
                        child: Text(
                          'Takes $activityDuration minutes',
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
                            spaceing: 15,
                          ).value,
                        ),
                        child: Obx(
                          () => Text(
                            _activityController.activeStep.value!.stepContent!,
                            style: AppTextStyle.growthtext,
                            textScaleFactor: textScaleFactor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: ScaleManager.spaceScale(spaceing: 14).value,
                      bottom: ScaleManager.spaceScale(spaceing: 14).value,
                    ),
                    child: BottomRightButton(
                      title: '',
                      onPressed: () {
                        _activityController.changePage(
                          action: NavAction.MoveForward,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
