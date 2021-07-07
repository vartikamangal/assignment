// Flutter imports:
// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/activity-management/presentation/widget/activity_type_widgets/activty-content-injector.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/duration-tracker/duration-tracker-controller.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/controller/voice-notes-controller.dart';

import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottom-middle-button.dart';
import '../controller/path-controller.dart';

class PathInfoSection3 extends StatelessWidget {
  final PathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.unfocusAllFields();
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          //resizeToAvoidBottomInset: false,
          // appBar: AppBar(
          //   backgroundColor: Theme.of(context).canvasColor,
          //   elevation: 0,
          //   leading: TopAppBar(onPressed: (){Navigator.of(context).pop();}),
          //   bottom: PreferredSize(
          //     preferredSize: Size(Get.width, 2),
          //     child: Obx(
          //       () => _controller.isProcessing.value
          //           ? const MiniLoader()
          //           : EmptySpacePlaceHolder(),
          //     ),
          //   ),
          // ),
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
                    child: const ActivityContentInjector(
                      activityType: ActivityType.TEXT,
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
                      () => _controller.footerVisibility
                          ? FooterContent(controller: _controller)
                          : EmptySpacePlaceHolder(),
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

class FooterContent extends StatelessWidget {
  FooterContent({
    Key? key,
    required PathController controller,
  })   : _controller = controller,
        super(key: key);

  final PathController _controller;
  final DurationTrackerController _durationController = Get.find();

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
              // GestureDetector(
              //   //TODO Remove the recent activity caching logic from here
              //   onTap: () async {
              //     await _controller
              //         .updateActivityStatusTrigger(
              //       actionStatus: ActionStatus.SCHEDULED_FOR_LATER,
              //     )
              //         // If user skips, take him to onboarding incomplete portion
              //         .then(
              //       (value) {
              //         // Takes you back to the intant-relief recommendations page if your were performing an intant activity
              //         _controller.navigateBasedOnActivity();
              //       },
              //     ).then((value) {
              //       /// After the data is sent make the footer invisible again
              //       _controller.footerVisibility = false;
              //     }).then((value) {
              //       Get.find<VoiceNoteController>().resetPlayerState();
              //     });
              //   },
              //   child: Text(
              //     'DO LATER',
              //     textScaleFactor: textScaleFactor,
              //     style: AppTextStyle.hintStyle.copyWith(
              //       color: blueDarkShade,
              //       decoration: TextDecoration.underline,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: ScaleManager.spaceScale(
              //     spaceing: 8,
              //   ).value,
              // ),
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
                    await _controller.persistFeedbacks().then((value) {
                      /// After the data is sent make the footer invisible again
                      _controller.footerVisibility = true;
                    }).then((value) {
                      Get.find<VoiceNoteController>().resetPlayerState();
                    });
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
