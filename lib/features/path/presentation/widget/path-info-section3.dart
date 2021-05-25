import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/responsive-builder.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/presentation/controller/choose-path-controller.dart';

import '../../../../core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottom-middle-button.dart';
import '../../../../core/utils/buttons/mic_button.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controller/path-controller.dart';

class PathInfoSection3 extends StatelessWidget {
  final PathController _controller = Get.find();
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    final bool _isSmallWinsActivity =
        Get.find<ChoosePathController>().selectedJourney.value.pathName ==
            'SMALL_WINS';
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, RouteName.pathInfoSection2);
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
                  children: [
                    SizedBox(
                      width: ScaleManager.spaceScale(spaceing: Get.width * 0.32)
                          .value,
                    ),
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
                  child: Text(
                    _isSmallWinsActivity
                        ? _controller.selectedActivity.value.activity.title
                        : _controller.selectedDayPlan.value.title,
                    style: AppTextStyle.Askfeeling,
                    textScaleFactor: textScaleFactor,
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
                  child: Text(
                    _isSmallWinsActivity
                        ? _controller
                            .templateToRecommendationMapperSelf['CONTENT']
                            .stepContent
                        : _controller
                            .templateToRecommendationMapperGuided['CONTENT']
                            .stepContent,
                    style: AppTextStyle.Darkbluebold,
                    textScaleFactor: textScaleFactor,
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
                    child: Responsive(
                      mobile: _TextInputComponent(
                        focusNode: focusNode,
                        micSize: 40,
                        fontSize: 18,
                      ),
                      tablet: _TextInputComponent(
                        focusNode: focusNode,
                        micSize: 40,
                        fontSize: 32,
                      ),
                      desktop: _TextInputComponent(
                        focusNode: focusNode,
                        micSize: 40,
                        fontSize: 18,
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
                      child: BottomMiddleButton(
                        title: tr('i am done').toUpperCase(),
                        onPressed: () {
                          Navigator.of(context).pushNamed(RouteName.onBoardingIncomplete);
                          /*
                          Get.offAllNamed(
                            RouteName.playSection1,
                          );
                          Future.delayed(const Duration(milliseconds: 1000), () {
                            Get.offAllNamed(RouteName.pathPlaySection2);
                          });
                          */
                          },
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
    );
  }
}

class _TextInputComponent extends StatelessWidget {
  const _TextInputComponent({
    Key key,
    @required this.focusNode,
    @required this.micSize,
    @required this.fontSize,
  }) : super(key: key);

  final FocusNode focusNode;
  final double micSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyle.hintStyle.copyWith(
        color: Colors.black,
        fontSize: fontSize,
      ),
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: 'Write here',
        hintStyle: AppTextStyle.hintStyle.copyWith(
          fontSize: fontSize,
        ),
        suffixIcon: SizedBox(
          height: ScaleManager.spaceScale(spaceing: micSize).value,
          width: ScaleManager.spaceScale(spaceing: micSize).value,
          child: const Mic_Button(),
        ),
      ),
    );
  }
}
