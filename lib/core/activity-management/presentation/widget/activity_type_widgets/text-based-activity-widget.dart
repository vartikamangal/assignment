import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tatsam_app_experimental/core/activity-management/presentation/controller/path-controller.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/responsive-builder.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/mic_button.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/mini-loader.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/controller/voice-notes-controller.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/widgets/voice-note-note-player-ui-fragment.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/widgets/voice-note-recorder-ui-fragment.dart';

class TextBasedActivity extends StatelessWidget {
  TextBasedActivity({
    Key key,
  }) : super(key: key);

  final PathController _controller = Get.find();
  final VoiceNoteController _voiceNoteController = Get.find();

  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopAppBar(onPressed: (){Navigator.of(context).pop();}),
      PreferredSize(
          preferredSize: Size(Get.width, 2),
          child: Obx(
            () => _controller.isProcessing.value
                ? const MiniLoader()
                : EmptySpacePlaceHolder(),
          ),
        ),
          SizedBox(
            height: ScaleManager.spaceScale(spaceing: 23).value,
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
              left: ScaleManager.spaceScale(spaceing: 28).value,
              right: ScaleManager.spaceScale(spaceing: 28).value,
              top: ScaleManager.spaceScale(spaceing: 30).value,
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
              left: ScaleManager.spaceScale(spaceing: 28).value,
              right: ScaleManager.spaceScale(spaceing: 28).value,
              top: ScaleManager.spaceScale(spaceing: 18).value,
            ),
            child: Obx(
                  () => Text(
                _controller.userSelectedPath.value == 'BIG_GOALS'
                    ? _controller.templateToRecommendationMapperGuided['CONTENT']
                    .stepContent
                    : _controller.templateToRecommendationMapperSelf['CONTENT']
                    .stepContent,
                style: AppTextStyle.Darkbluebold,
                textScaleFactor: textScaleFactor,
              ),
            ),
          ),
          _FeedbackComponent(
            voiceNoteController: _voiceNoteController,
            controller: _controller,
          ),
        ],
      ),
    );
  }
}

class _FeedbackComponent extends StatelessWidget {
  const _FeedbackComponent({
    Key key,
    @required VoiceNoteController voiceNoteController,
    @required PathController controller,
  })  : _voiceNoteController = voiceNoteController,
        _controller = controller,
        super(key: key);

  final VoiceNoteController _voiceNoteController;
  final PathController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              () {
            if (_voiceNoteController.isRecording.value) {
              return VoiceNoteRecorder();
            }

            /// If current state is not recording and some file is present in controller for playing
            if (_voiceNoteController.isPlayableFilePresent()) {
              return VoiceNotePlayer();
            } else {
              return Responsive(
                mobile: _TextInputComponent(
                  voiceNoteController: _voiceNoteController,
                  micSize: 40,
                  fontSize: 18,
                  controller: _controller,
                ),
                tablet: _TextInputComponent(
                  micSize: 40,
                  fontSize: 32,
                  voiceNoteController: _voiceNoteController,
                  controller: _controller,
                ),
                desktop: _TextInputComponent(
                  voiceNoteController: _voiceNoteController,
                  micSize: 40,
                  fontSize: 18,
                  controller: _controller,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _TextInputComponent extends StatelessWidget {
  const _TextInputComponent({
    Key key,
    @required this.micSize,
    @required this.fontSize,
    @required this.controller,
    @required this.voiceNoteController,
  }) : super(key: key);

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
      focusNode: controller.focusNode,
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