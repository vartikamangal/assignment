// Flutter imports:
// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/cache-manager/presentation/controllers/activity_cache_controller.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/duration-tracker/duration-tracker-controller.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/content_page_controller.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/perform-activity-controller.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/text_content_controller.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/controller/voice-notes-controller.dart';

import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottom-middle-button.dart';

class ContentScreen extends StatelessWidget {
  final PerformActivityController activityController = Get.find();
  final ContentPageController _contentPageController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => activityController.refreshStateOnBackButtonPress(),
      child: GestureDetector(
        onTap: () {
          _contentPageController.unfocusTextField();
        },
        child: SafeArea(
          top: false,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: ScaleManager.spaceScale(spaceing: 40).value),
                      child: Obx(
                        () => _contentPageController.contentWidget.value,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: ScaleManager.spaceScale(spaceing: 14).value,
                          left: ScaleManager.spaceScale(spaceing: 32).value,
                          right: ScaleManager.spaceScale(
                            spaceing: 14,
                          ).value),
                      child: Obx(
                        () => activityController.footerVisibility
                            ? FooterContent(controller: activityController)
                            : EmptySpacePlaceHolder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FooterContent extends StatelessWidget {
  FooterContent({
    Key? key,
    required PerformActivityController controller,
  })   : _controller = controller,
        super(key: key);

  final PerformActivityController _controller;
  final DurationTrackerController _durationController = Get.find();
  final ActivityCacheController cacheController = Get.find();
  final ContentPageController _contentPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: ScaleManager.spaceScale(
              spaceing: 196,
            ).value,
            child: Padding(
              padding: EdgeInsets.only(
                right: ScaleManager.spaceScale(
                  spaceing: 9,
                ).value,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: ScaleManager.spaceScale(
                  spaceing: 13,
                ).value),
                child: Text(
                  'End to end encrypted : Everything you write here will be only visible to your eyes. We won’t have access to it.',
                  style: AppTextStyle.verySmallGreyText,
                  textScaleFactor: textScaleFactor,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  await Future.value([
                    _controller.updateActivityStatusTrigger(
                      actionStatus: ActionStatus.SCHEDULED_FOR_LATER,
                      acitivtyId: _controller.onGoingActivityStatus.value!.id!,
                    ),
                    _controller.navigatePostActivityCompletion(),
                  ]);
                },
                child: Text(
                  'DO LATER',
                  textScaleFactor: textScaleFactor,
                  style: AppTextStyle.hintStyle.copyWith(
                    color: blueDarkShade,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 8,
                ).value,
              ),
              SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 56,
                ).value,
                width: ScaleManager.spaceScale(
                  spaceing: 158,
                ).value,
                child: BottomMiddleButton(
                  title: tr('i am done').toUpperCase(),
                  onPressed: () async {
                    _durationController.stop();
                    Get.find<TextContentController>().cacheActivityFeedback(
                      activityType: _controller.activeStep.value!.templateName!,
                    );
                    Get.find<VoiceNoteController>().resetPlayerState();
                    Get.toNamed(RouteName.activityCompletionScreen);
                    _controller.footerVisibility = true;
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
