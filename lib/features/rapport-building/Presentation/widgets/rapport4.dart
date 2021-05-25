import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/responsive-builder.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/utils/animations/fade-animation-x-axis.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/widgets/voicenote-modal.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/mic_button.dart';
import '../controllers/rapport-building-controller.dart.dart';

class MidPageContentsD extends StatelessWidget {
  final RapportBuildingController _onBoardingController = Get.find();
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final imageScale = ScaleManager.imageScale.value;
    final textScale = ScaleManager.textScale.value;
    return
      Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: ScaleManager.spaceScale(
                spaceing: 32,
              ).value,
              right: 1,
            ),
            width: Get.width,
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 10,
                  ).value,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScaleManager.spaceScale(
                      spaceing: 20,
                    ).value,
                  ),
                  child: SizedBox(
                    width: ScaleManager.spaceScale(
                      spaceing: 89,
                    ).value,
                    height: ScaleManager.spaceScale(
                      spaceing: 88,
                    ).value,
                    child: Image.asset(
                      '${ImagePath.lightBlueEmoji}${'${_onBoardingController.selectedEmotion.value}.png'}',
                      scale: imageScale,
                    ),
                  ),
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 12,
                  ).value,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: ScaleManager.spaceScale(
                      spaceing: 100,
                    ).value,
                  ),
                  child: Text(
                    tr('additional details text'),
                    style: AppTextStyle.titleM,
                    textScaleFactor: textScale,
                  ),
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 5,
                  ).value,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: ScaleManager.spaceScale(
                      spaceing: 32,
                    ).value,
                  ),
                  child: FadeAnimationXAxis(
                    0.0, Text(
                    tr('additional details title'),
                    style: AppTextStyle.titleL,
                    textScaleFactor: textScale,
                  ),
                  ),
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 5,
                  ).value,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: Get.width * 0.82),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Responsive(
                      mobile: _TextFormFieldComponent(
                        onBoardingController: _onBoardingController,
                        textController: _textController,
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
                        fontSize: 18,
                      ),
                      tablet: _TextFormFieldComponent(
                        onBoardingController: _onBoardingController,
                        textController: _textController,
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
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: ScaleManager.spaceScale(
              spaceing: 32,
            ).value,
            right: ScaleManager.spaceScale(
              spaceing: 34,
            ).value,
            bottom: ScaleManager.spaceScale(
              spaceing: 120,
            ).value,
            child: Text(
              tr(
                'Did you know: We cope better with problems when we observe ourselves and emotions, rather than participate in them',
              ),
              style: AppTextStyle.titleM,
              textScaleFactor: textScale,
            ),
          )
        ],
      );
  }
}

class _TextFormFieldComponent extends StatelessWidget {
  const _TextFormFieldComponent({
    Key key,
    @required RapportBuildingController onBoardingController,
    @required TextEditingController textController,
    @required this.edgeInsets,
    @required this.fontSize,
    @required this.micIconSize,
  })  : _onBoardingController = onBoardingController,
        _textController = textController,
        super(key: key);

  final RapportBuildingController _onBoardingController;
  final TextEditingController _textController;
  final EdgeInsets edgeInsets;
  final double fontSize;
  final double micIconSize;

  @override
  Widget build(BuildContext context) {
    return FadeAnimationXAxis(
      0.1, TextField(
      focusNode: _onBoardingController.focusNode,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 3,
      style: AppTextStyle.hintStyleDarkerForTextInputs.copyWith(
        color: Colors.grey[700],
        fontSize: fontSize,
      ),
      controller: _textController,
      decoration: InputDecoration(
        contentPadding: edgeInsets,
        hintText: tr('additional details field'),
        hintStyle: AppTextStyle.hintStyle.copyWith(
          fontSize: fontSize,
        ),
        suffixIcon: SizedBox(
          height: micIconSize,
          width: micIconSize,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VoiceNoteModal(),
                ),
              );
            },
            child: SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 40,
                ).value,
                width: ScaleManager.spaceScale(
                  spaceing: 40,
                ).value,
                child: const Mic_Button()),
          ),
        ),
      ),
      onChanged: (feeling) {
        _onBoardingController.userFeeling = feeling;
      },
    ),
    );
  }
}