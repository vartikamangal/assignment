// Flutter imports:
import 'package:animator/animator.dart';
// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/perform-activity-controller.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';

import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottom-right-text-button.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/widgets/null-handled-image.dart';

class InstructionsScreen extends StatelessWidget {
  final PerformActivityController _activityController = Get.find();
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    return WillPopScope(
      onWillPop: () => _activityController.refreshStateOnBackButtonPress(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                  minHeight: Get.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom),
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
                        onPressed: () =>
                            _activityController.refreshStateOnBackButtonPress(),
                      ),
                      SizedBox(
                        height: ScaleManager.spaceScale(spaceing: 23).value,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NullHandledImage(image:  _activityController.activity.value!.iconVO!.url,)
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
                        child: Obx(
                          () => Text(
                            _activityController.activity.value!.title!,
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
                        child: Text(
                          'Takes ${_activityController.activity.value!.durationInMinutes} minutes',
                          style: AppTextStyle.getTimerText,
                          textScaleFactor: textScaleFactor,
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
                              spaceing: 15,
                            ).value),
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
                        right: ScaleManager.spaceScale(
                          spaceing: 14,
                        ).value,
                        bottom: ScaleManager.spaceScale(
                          spaceing: 14,
                        ).value),
                    child: Animator<double>(
                      curve: Curves.easeInOut,
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 400),
                      builder: (context, animatorState, child) =>
                          Transform.translate(
                        offset: Offset(animatorState.value, 1),
                        child: SizedBox(
                          width: ScaleManager.spaceScale(
                            spaceing: 158,
                          ).value,
                          child: BottomRightTextButton(
                            title: tr('i got it'),
                            onPressed: () {
                              _activityController.changePage(
                                action: NavAction.MoveForward,
                              );
                            },
                          ),
                        ),
                      ),
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
