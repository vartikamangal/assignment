// Flutter imports:
// Package imports:
import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/linear-progress-indicator.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/controller/voice-notes-controller.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/widgets/voice-note-ui-fragment.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/controllers/rapport-content-according-to-mood.dart';

import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/responsive-builder.dart';
import '../../../../core/responsive/scale-manager.dart';
//import '../../../../core/utils/animations/diagonal-animation-from-bottomright.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/mic_button.dart';

class MidPageContentsD extends StatelessWidget {
  final RapportBuildingController _onBoardingController = Get.find();
  final VoiceNoteController _voiceNoteController = Get.find();
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final imageScale = ScaleManager.imageScale.value;
    final textScale = ScaleManager.textScale.value;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Image.asset(
              ImagePath.topRightLeaf,
              width: size.width,
              // fit: BoxFit.fitWidth,
              scale: imageScale,
            ),
          ),
          Positioned(
              left: ScaleManager.spaceScale(
                spaceing: 3,
              ).value,
              top: ScaleManager.spaceScale(
                spaceing: 9,
              ).value,
              child: TopAppBar(onPressed: () {
                _onBoardingController.navigateBack();
              })),
          Container(
            padding: EdgeInsets.only(
              left: ScaleManager.spaceScale(
                spaceing: 35,
              ).value,
              right: 1,
            ),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 37,
                  ).value,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScaleManager.spaceScale(
                      spaceing: 35,
                    ).value,
                  ),
                  child: SizedBox(
                    width: ScaleManager.spaceScale(
                      spaceing: 89,
                    ).value,
                    height: ScaleManager.spaceScale(
                      spaceing: 88,
                    ).value,
                    child:CachedNetworkImage(
                      imageUrl:_onBoardingController.selectedEmotionIconUrl.value,
                      height:ScaleManager.spaceScale(
                        spaceing: 88,
                      ).value ,
                    ),
                  ),
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 16,
                  ).value,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: ScaleManager.spaceScale(
                      spaceing: 50,
                    ).value,
                  ),
                  child: Text(
                    rapportData[_onBoardingController
                            .selectedMood.value!.moodName!]!
                        .feelingPageContent
                        .textTop,
                    style: AppTextStyle.titleM,
                    textScaleFactor: textScale,
                  ),
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 10,
                  ).value,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: ScaleManager.spaceScale(
                      spaceing: 32,
                    ).value,
                  ),
                  child: Animator<double>(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                    builder: (context, animatorState, child) => Opacity(
                      opacity: animatorState.value,
                      child: Text(
                        rapportData[_onBoardingController
                                .selectedMood.value!.moodName!]!
                            .feelingPageContent
                            .textMid,
                        style: AppTextStyle.titleL,
                        textScaleFactor: textScale,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 10,
                  ).value,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: Get.width * 0.82),
                  child: SingleChildScrollView(
                    reverse: true,

                    /// If user has recorded something in this session then show him
                    /// voicenote fragement else show him basic flow ui
                    child: Obx(() {
                      /// If current state is recording
                      if (_voiceNoteController.playerState.value !=
                          VoiceNotePlayerUIState.IDLE) {
                        return VoiceNoteFragment();
                      } else {
                        /// IDLE state
                        return Responsive(
                          mobile: _TextFormFieldComponent(
                            onBoardingController: _onBoardingController,
                            textController: _textController,
                            voiceNoteController: _voiceNoteController,
                            micIconSize:
                                ScaleManager.spaceScale(spaceing: 40).value,
                            edgeInsets: EdgeInsets.only(
                              left: ScaleManager.spaceScale(
                                spaceing: 3,
                              ).value,
                              bottom: ScaleManager.spaceScale(
                                spaceing: 6,
                              ).value,
                            ),
                            fontSize: ScaleManager.spaceScale(
                              spaceing: 18,
                            ).value,
                          ),
                          tablet: _TextFormFieldComponent(
                            onBoardingController: _onBoardingController,
                            textController: _textController,
                            voiceNoteController: _voiceNoteController,
                            micIconSize:
                                ScaleManager.spaceScale(spaceing: 40).value,
                            edgeInsets: EdgeInsets.only(
                              left: ScaleManager.spaceScale(
                                spaceing: 3,
                              ).value,
                              bottom: ScaleManager.spaceScale(
                                spaceing: 6,
                              ).value,
                            ),
                            fontSize: 35,
                          ),
                          desktop: _TextFormFieldComponent(
                            onBoardingController: _onBoardingController,
                            textController: _textController,
                            voiceNoteController: _voiceNoteController,
                            micIconSize: ScaleManager.spaceScale(
                              spaceing: 40,
                            ).value,
                            edgeInsets: EdgeInsets.only(
                              left: ScaleManager.spaceScale(
                                spaceing: 3,
                              ).value,
                              bottom: ScaleManager.spaceScale(
                                spaceing: 6,
                              ).value,
                            ),
                            fontSize: 18,
                          ),
                        );
                      }
                    }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: ScaleManager.spaceScale(
                        spaceing: 30,
                      ).value,
                      top: ScaleManager.spaceScale(
                        spaceing: 70,
                      ).value,
                      right: ScaleManager.spaceScale(
                        spaceing: 34,
                      ).value),
                  child: Animator<double>(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                    builder: (context, animatorState, child) => Opacity(
                      opacity: animatorState.value,
                      child: Text(
                        rapportData[_onBoardingController
                                .selectedMood.value!.moodName!]!
                            .feelingPageContent
                            .textBottom,
                        style: AppTextStyle.titleM,
                        textScaleFactor: textScale,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(
                () => _onBoardingController.isProcessing.value
                ? CustomizedLinearProgressIndicator()
                : Container(),
          ),
        ],
      ),
    );
  }
}

class _TextFormFieldComponent extends StatelessWidget {
  const _TextFormFieldComponent({
    Key? key,
    required RapportBuildingController onBoardingController,
    required TextEditingController textController,
    required this.edgeInsets,
    required this.fontSize,
    required this.micIconSize,
    required this.voiceNoteController,
  })   : _onBoardingController = onBoardingController,
        _textController = textController,
        super(key: key);

  final RapportBuildingController _onBoardingController;
  final VoiceNoteController voiceNoteController;
  final TextEditingController _textController;
  final EdgeInsets edgeInsets;
  final double fontSize;
  final double micIconSize;

  @override
  Widget build(BuildContext context) {
    return Animator<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      builder: (context, animatorState, child) => Opacity(
        opacity: animatorState.value,
        child: TextField(
          focusNode: _onBoardingController.focusNode,
          keyboardType: TextInputType.emailAddress,
          minLines: 1,
          maxLines: 3,
          style: AppTextStyle.hintStyleDarkerForTextInputs.copyWith(
            color: blueDarkShade,
            fontWeight: FontWeight.w500,
            fontSize: ScaleManager.spaceScale(
              spaceing: 18,
            ).value,
          ),
          controller: _textController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: ScaleManager.spaceScale(
              spaceing: 10,
            ).value),
            hintText: tr('additional details field'),
            hintStyle: AppTextStyle.hintStyle.copyWith(
              fontSize: fontSize,
            ),
            suffixIconConstraints: BoxConstraints(
                minWidth: ScaleManager.spaceScale(
                  spaceing: 35,
                ).value,
                maxHeight: ScaleManager.spaceScale(
                  spaceing: 35,
                ).value),
            suffixIcon: SizedBox(
              height: micIconSize,
              width: micIconSize,
              child: GestureDetector(
                onTap: () async {
                  await voiceNoteController.recordVoiceNote();
                },
                child: const Mic_Button(),
              ),
            ),
          ),
          onChanged: (feeling) {
            _onBoardingController.userFeeling = feeling;
          },
        ),
      ),
    );
  }
}
