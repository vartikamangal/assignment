// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/duration-tracker/duration-tracker-controller.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/controller/voice-notes-controller.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/widgets/voice-note-ui-fragment.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/responsive-builder.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottom-middle-button.dart';
import '../../../../core/utils/buttons/mic_button.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controller/path-controller.dart';

class PathInfoSection3 extends StatelessWidget {
  final PathController _controller = Get.find();
  final _durationController = Get.find<DurationTrackerController>();
  final _voiceNoteController = Get.find<VoiceNoteController>();
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: blueDarkShade,
                size: ScaleManager.spaceScale(
                  spaceing: 26,
                ).value,
              ),
            ),
          ),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: ScaleManager.spaceScale(spaceing: 15).value,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        _controller.selectedActivityTitle.value,
                        style: AppTextStyle.Askfeeling,
                        textScaleFactor: textScaleFactor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScaleManager.spaceScale(
                        spaceing: 28,
                      ).value,
                      right: ScaleManager.spaceScale(
                        spaceing: 28,
                      ).value,
                      top: ScaleManager.spaceScale(spaceing: 18).value,
                    ),
                    child: Obx(
                      () => Text(
                        _controller.userSelectedPath.value == 'BIG_GOALS'
                            ? _controller
                                .templateToRecommendationMapperGuided['CONTENT']
                                .stepContent
                            : _controller
                                .templateToRecommendationMapperSelf['CONTENT']
                                .stepContent,
                        style: AppTextStyle.Darkbluebold,
                        textScaleFactor: textScaleFactor,
                      ),
                    ),
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
                        spaceing: 25,
                      ).value,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: ScaleManager.spaceScale(
                          spaceing: Get.width,
                        ).value,
                      ),
                      child: Obx(
                        () => _voiceNoteController.isRecording.value
                            ? VoiceNoteRecorderFragment()
                            : Responsive(
                                mobile: _TextInputComponent(
                                  focusNode: focusNode,
                                  voiceNoteController: _voiceNoteController,
                                  micSize: 40,
                                  fontSize: 18,
                                  controller: _controller,
                                ),
                                tablet: _TextInputComponent(
                                  focusNode: focusNode,
                                  micSize: 40,
                                  fontSize: 32,
                                  voiceNoteController: _voiceNoteController,
                                  controller: _controller,
                                ),
                                desktop: _TextInputComponent(
                                  focusNode: focusNode,
                                  voiceNoteController: _voiceNoteController,
                                  micSize: 40,
                                  fontSize: 18,
                                  controller: _controller,
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: ScaleManager.spaceScale(
                  spaceing: 16,
                ).value,
                left: ScaleManager.spaceScale(
                  spaceing: 32,
                ).value,
                right: ScaleManager.spaceScale(
                  spaceing: 16,
                ).value,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: ScaleManager.spaceScale(
                              spaceing: 9,
                            ).value,
                          ),
                          child: Text(
                            'End to end encrypted : Everything you write here will be only visible to your eyes. We won’t have access to it.',
                            style: AppTextStyle.verySmallGreyText,
                            textScaleFactor: textScaleFactor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              //TODO clean this mess
                              onTap: () async {
                                await _controller
                                    .updateActivityStatusTrigger(
                                  actionStatus:
                                      ActionStatus.SCHEDULED_FOR_LATER,
                                )
                                    // If user skips, take him to onboarding incomplete portion
                                    .then(
                                  (value) {
                                    // Takes you back to the intant-relief recommendations page if your were performing an intant activity
                                    _controller.navigateBasedOnActivity();
                                  },
                                );
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
                            BottomMiddleButton(
                              title: tr('i am done').toUpperCase(),
                              onPressed: () async {
                                _durationController.stop();
                                await _controller.persistFeedbacks();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                right: ScaleManager.spaceScale(
                  spaceing: Get.width * 0.039,
                ).value,
                bottom: ScaleManager.spaceScale(
                  spaceing: Get.height * 0.022,
                ).value,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: ScaleManager.spaceScale(
                      spaceing: 10,
                    ).value,
                    right: ScaleManager.spaceScale(
                      spaceing: 10,
                    ).value,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TextInputComponent extends StatelessWidget {
  const _TextInputComponent({
    Key key,
    @required this.focusNode,
    @required this.micSize,
    @required this.fontSize,
    @required this.controller,
    @required this.voiceNoteController,
  }) : super(key: key);

  final FocusNode focusNode;
  final double micSize;
  final double fontSize;
  final PathController controller;
  final VoiceNoteController voiceNoteController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyle.hintStyle.copyWith(
        color: blueDarkShade,
        fontSize: fontSize,
      ),
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: 'Write here',
        hintStyle: AppTextStyle.hintStyle.copyWith(
          fontSize: fontSize,
        ),
        suffixIcon: SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: micSize,
          ).value,
          width: ScaleManager.spaceScale(
            spaceing: micSize,
          ).value,
          child: GestureDetector(
            onTap: () async {
              await voiceNoteController.recordVoiceNote();
            },
            child: Padding(
              padding: EdgeInsets.only(
                bottom: ScaleManager.spaceScale(
                  spaceing: 9.0,
                ).value,
              ),
              child: const Mic_Button(),
            ),
          ),
        ),
      ),
      onChanged: (recommendationText) {
        controller.textFeedback = recommendationText;
      },
    );
  }
}
