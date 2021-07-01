// Flutter imports:
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottom-right-text-button.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controller/path-controller.dart';

class PathInfoSection2 extends StatelessWidget {
  final PathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).canvasColor,
        //   elevation: 0,
        //   leading: TopAppBar(onPressed:(){Navigator.of(context).pop();}),
        //   bottom: PreferredSize(
        //     preferredSize: Size(Get.width, 2),
        //     child: Obx(
        //       () => _controller.isProcessing.value
        //           ? const LinearProgressIndicator()
        //           : EmptySpacePlaceHolder(),
        //     ),
        //   ),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PreferredSize(
                    preferredSize: Size(Get.width, 2),
                    child: Obx(
                          () => _controller.isProcessing.value
                          ? const LinearProgressIndicator()
                          : EmptySpacePlaceHolder(),
                    ),
                  ),
                  TopAppBar(onPressed:(){Navigator.of(context).pop();}),
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
                          height: ScaleManager.spaceScale(spaceing: 140).value,
                          width: ScaleManager.spaceScale(spaceing: 138).value,
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
                        spaceing: 32,
                      ).value,
                      right: ScaleManager.spaceScale(
                        spaceing: 28,
                      ).value,
                    ),
                    child: Text(
                      'Takes ${_controller.activityDuration} minutes',
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
                        _controller.userSelectedPath.value == "BIG_GOALS"
                            ? _controller
                                .templateToRecommendationMapperGuided[
                                    'INSTRUCTIONS']
                                .stepContent
                            : _controller
                                .templateToRecommendationMapperSelf[
                                    'INSTRUCTIONS']
                                .stepContent,
                        style: AppTextStyle.growthtext,
                        textScaleFactor: textScaleFactor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: ScaleManager.spaceScale(
                spaceing: 14,
              ).value,
                  bottom: ScaleManager.spaceScale(
                    spaceing: 14,
                  ).value),
              child: Animator<double>(
                curve: Curves.easeInOut,
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 400),
                builder: (context, animatorState, child) => Transform.translate (
                 offset: Offset(animatorState.value, 1),
                  child: SizedBox(
                    width: ScaleManager.spaceScale(
                      spaceing: 150,
                    ).value,
                    child: BottomRightTextButton(
                      title: tr('i got it'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          RouteName.pathInfoSection3,
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
    );
  }
}
